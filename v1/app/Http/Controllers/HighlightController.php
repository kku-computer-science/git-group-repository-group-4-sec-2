<?php

namespace App\Http\Controllers;


use App\Models\ImageCollection;
use Illuminate\Http\Request;
use App\Models\Highlight;
use App\Models\Tag;
use Intervention\Image\ImageManager;
use Illuminate\Support\Facades\Storage;
use Intervention\Image\Drivers\Imagick\Driver;
// use Intervention\Image\Drivers\Gd\Driver;
use Intervention\Image\Encoders\JpegEncoder;
use Illuminate\Support\Facades\Log;

use Intervention\Image\Encoders\PngEncoder;
use Intervention\Image\Encoders\GifEncoder;
use Intervention\Image\Encoders\WebpEncoder;


class HighlightController extends Controller
{
    public function index()
    {
        $highlights = Highlight::with(['tags:id,name', 'user:id,fname_th,lname_th', 'images']) 
            ->where('status', 1)
            ->get(['id', 'image', 'title', 'user_id', 'created_at']); 
    
        $news = Highlight::whereNull('status')
            ->with(['tags:id,name', 'user:id,fname_th,lname_th', 'images']) 
            ->get(['id', 'image', 'title', 'user_id', 'created_at']);
    
        return view('highlights.index', compact('highlights', 'news'));
    }

    public function create()
    {
        $categories = Tag::all();
        return view('highlights.create', compact('categories'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'tag_id' => 'required|array', // ✅ ต้องเป็น array
            'tag_id.*' => 'exists:tag,id', // ✅ ตรวจสอบว่าแต่ละ tag_id มีอยู่จริง
            'link' => 'nullable|url',
            'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
            'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120'
        ]);
        $manager = new ImageManager(new Driver()); // ใช้ GD หรือ Imagick

        $coverImagePath = null;

        if ($request->hasFile('cover_image')) {
            $coverFile = $request->file('cover_image');
            $extension = $coverFile->getClientOriginalExtension();
            $mime = $coverFile->getMimeType();

            // ตรวจสอบและเลือก Encoder ที่เหมาะสม
            $encoder = match ($mime) {
                'image/png' => new PngEncoder(),
                'image/gif' => new GifEncoder(),
                'image/webp' => new WebpEncoder(80),
                default => new JpegEncoder(80) // ค่าเริ่มต้นเป็น JPG
            };

            $image = $manager->read($coverFile->getPathname())
                ->scale(width: 1200)
                ->encode($encoder);

            $fileName = 'highlightImage/' . uniqid() . '.' . $extension;
            Storage::disk('public')->put($fileName, $image->toString());
            $coverImagePath = $fileName;
        }


        $highlight = Highlight::create([
            'title' => $request->title,
            'description' => $request->description,
            'image' => $request->file('cover_image') ? $request->file('cover_image')->store('highlightImage', 'public') : null,
            'link' => $request->link,
            'status' => null,
            'user_id' => auth()->id(),
        ]);
    
        // ✅ ใช้ `sync()` เชื่อม Many-to-Many ผ่าน Pivot Table `highlight_has_tag`
        $highlight->tags()->sync($request->tag_id);
    
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $imageFile) {
                $extension = $imageFile->getClientOriginalExtension();
                $mime = $imageFile->getMimeType();

                $encoder = match ($mime) {
                    'image/png' => new PngEncoder(),
                    'image/gif' => new GifEncoder(),
                    'image/webp' => new WebpEncoder(80),
                    default => new JpegEncoder(80)
                };

                $image = $manager->read($imageFile->getPathname())
                    ->scale(width: 1200)
                    ->encode($encoder);

                $fileName = 'imagecollection/' . uniqid() . '.' . $extension;
                Storage::disk('public')->put($fileName, $image->toString());

                ImageCollection::create([
                    'image' => $fileName,
                    'highlight_id' => $highlight->id,
                ]);
            }
        }

        return redirect()->route('highlights.index')->with('success', 'Highlight created successfully!');
    }

    public function edit($id)
    {
        Log::info('Edit Highlight ID: 1');
        $highlight = Highlight::with('tags','images')->findOrFail($id);
        Log::info('Edit Highlight ID: 2');
        $categories = Tag::all();
        Log::info('Edit Highlight ID: 3');
        $selectedTags = $highlight->tags->pluck('id')->toArray();
        Log::info('Edit Highlight ID: 4');
        return view('highlights.edit', compact('highlight', 'categories','selectedTags'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'tag_id' => 'required|array',
            'tag_id.*' => 'exists:tag,id',
            'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
            'link' => 'nullable|url',
            'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
        ]);
    
        $highlight = Highlight::findOrFail($id);
        $manager = new ImageManager(new Driver());
        $coverImagePath = $highlight->image; // ✅ ตั้งค่าเริ่มต้นให้เป็นภาพเดิม
    
        if ($request->hasFile('cover_image')) {
            if ($highlight->image) {
                Storage::disk('public')->delete($highlight->image);
            }
            $image = $manager->read($request->file('cover_image')->getPathname())
                ->scale(width: 1200)
                ->encode(new JpegEncoder(80));
                $fileName = 'highlightImage/' . uniqid() . '.jpg';
                Storage::disk('public')->put($fileName, $image->toString());
                $coverImagePath = $fileName;
            }
    
        $highlight->update([
            'title' => $request->title,
            'description' => $request->description,
            'link' => $request->link,
            'image' => $coverImagePath, // ✅ ใช้ค่าที่กำหนด
        ]);
    
        $highlight->tags()->sync($request->tag_id);

        if ($request->deleted_images) {
            $deletedImageIds = json_decode($request->deleted_images, true);
            foreach ($deletedImageIds as $imageId) {
                $image = ImageCollection::find($imageId);
                if ($image) {
                    Storage::disk('public')->delete($image->image);
                    $image->delete();
                }
            }
        }

        // ✅ Upload New Images (If Any)
        if ($request->hasFile('images')) {
            foreach ($request->file('images') as $imageFile) {
                $fileName = $imageFile->store('imageCollection', 'public');

                ImageCollection::create([
                    'image' => $fileName,
                    'highlight_id' => $highlight->id,
                ]);
            }
        }
    
        return redirect()->route('highlights.index')->with('success', 'Highlight updated successfully!');
    }

    public function addToHighlights($id)
    {
        // Count current highlights with status 1
        $highlightCount = Highlight::where('status', 1)->count();

        // Check if the limit has been reached
        if ($highlightCount >= 5) {
            return redirect()->back()->with('error', 'Cannot add more than 5 highlights.');
        }
        // Find the news item and update status
        $highlight = Highlight::findOrFail($id);
        $highlight->status = 1; // Set as highlight
        $highlight->save();

        return redirect()->back()->with('success', 'Highlight added successfully.');
    }

    public function removeFromHighlights($id)
    {
        $highlight = Highlight::findOrFail($id);
        $highlight->status = null;
        $highlight->save();

        return redirect()->route('highlights.index')->with('success', 'Removed from Highlights!');
    }

    public function deleteImage($id)
    {
        Log::info('++++++++++++++++1');
        $image = ImageCollection::find($id);
        Log::info('++++++++++++++++2');

        if (!$image) {
            return response()->json(['error' => 'Image not found'], 404);
        }
        Log::info('++++++++++++++++3');

        // ลบไฟล์ออกจาก Storage
        Storage::disk('public')->delete($image->image);

        Log::info('++++++++++++++++4');
        // ลบจาก Database
        $image->delete();
        Log::info('++++++++++++++++5');

        return response()->json(['success' => true]);
    }

    public function destroy($id)
    {
        $highlight = Highlight::findOrFail($id);

        if ($highlight->image) {
            Storage::disk('public')->delete($highlight->image);
        }

        foreach ($highlight->images as $image) {
            Storage::disk('public')->delete($image->image);
            $image->delete();
        }

        $highlight->delete(); // ✅ ลบออกจาก Database

        return response()->json(['success' => true, 'message' => 'Highlight deleted successfully.']);
    }


    public function dataTable(Request $request)
    {
        $type = $request->query('type');

        $query = Highlight::with(['tag', 'user'])
            ->when($type === 'highlights', function ($q) {
                return $q->where('status', 1)->latest()->take(5);
            })
            ->when($type === 'news', function ($q) {
                return $q->whereNull('status')->latest()->take(5);
            });

        return datatables()->eloquent($query)
            ->addColumn('tag', function ($highlight) {
                return $highlight->tag->name ?? 'No Tag';
            })
            ->addColumn('created_by', function ($highlight) {
                return optional($highlight->user)->fname_th . ' ' . optional($highlight->user)->lname_th ?? 'Unknown';
            })
            ->addColumn('actions', function ($highlight) use ($type) {
                $editUrl = route('highlights.edit', $highlight->id);
                $deleteUrl = route('highlights.destroy', $highlight->id);
                $toggleUrl = ($type === 'highlights') ? route('highlights.remove', $highlight->id) : route('highlights.add', $highlight->id);
                $toggleText = ($type === 'highlights') ? 'REMOVE' : 'ADD';

                return '
                    <a href="' . $editUrl . '" class="btn btn-outline-primary btn-sm"><i class="fas fa-edit"></i></a>
                    <button class="btn btn-danger btn-sm delete-btn" data-url="' . $deleteUrl . '">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                    <form action="' . $toggleUrl . '" method="POST" style="display:inline;">
                        ' . csrf_field() . method_field('PUT') . '
                        <button type="submit" class="btn btn-warning btn-sm">' . $toggleText . '</button>
                    </form>
                ';
            })
            ->rawColumns(['image', 'actions'])
            ->make(true);
    }
}
