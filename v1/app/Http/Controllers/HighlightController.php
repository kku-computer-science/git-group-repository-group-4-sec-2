<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Log;
use App\Models\ImageCollection;
use Illuminate\Http\Request;
use App\Models\Highlight;
use App\Models\Category;
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
        $highlights = Highlight::with(['category:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->where('status', 1)
            ->get(['id', 'image', 'title', 'category_id', 'user_id', 'created_at']);

        $news = Highlight::whereNull('status')
            ->with(['category:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->get(['id', 'image', 'title', 'category_id', 'user_id', 'created_at']);

        return view('highlights.index', compact('highlights', 'news'));
    }

    public function create()
    {
        $categories = Category::all();
        return view('highlights.create', compact('categories'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'category_id' => 'required|exists:category,id',
            'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:5120',
            'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:5120',
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
            'category_id' => $request->category_id,
            'image' => $coverImagePath,
            'status' => null,
            'user_id' => auth()->id(),
        ]);

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

        return redirect()->route('highlights.index')->with('success', 'News created successfully!');
    }

    public function edit($id)
    {
        Log::info('Edit Highlight ID: 1');
        $highlight = Highlight::with('images')->findOrFail($id);
        Log::info('Edit Highlight ID: 2');
        $categories = Category::all();
        Log::info('Edit Highlight ID: 3');
        return view('highlights.edit', compact('highlight', 'categories'));
    }

    // public function update(Request $request, $id)
    // {
    //     $request->validate([
    //         'title' => 'required|string|max:255',
    //         'category_id' => 'required|exists:category,id',
    //         'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
    //         'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
    //     ]);
    //     Log::info('------=----1');
    //     $highlight = Highlight::findOrFail($id);
    //     $manager = new ImageManager(new Driver());
    //     $coverImagePath = $highlight->image;
        
    //     Log::info('------=----2');
    //     // ✅ อัปเดต Cover Image (เก็บใน `highlightImage/`)
    //     if ($request->hasFile('cover_image')) {
    //         if ($highlight->image) {
    //             Storage::disk('public')->delete($highlight->image); // ลบรูปเก่า
    //         }
    //         $image = $manager->read($request->file('cover_image')->getPathname())
    //         ->scale(width: 1200)
    //         ->encode(new JpegEncoder(80));
            
    //         $fileName = 'highlightImage/' . uniqid() . '.jpg';
    //         Storage::disk('public')->put($fileName, $image->toString());
    //         $coverImagePath = $fileName;
    //     }
    //     Log::info('------=----3');
        
    //     // ✅ อัปเดตข้อมูลในฐานข้อมูล
    //     $highlight->update([
    //         'title' => $request->title,
    //         'description' => $request->description,
    //         'category_id' => $request->category_id,
    //         'image' => $coverImagePath,
    //     ]);
    //     Log::info('------=----4');
        
    //     // ✅ อัปเดต Image Album (เก็บใน `imageCollection/`)
    //     if ($request->hasFile('images')) {
    //         // ลบรูปเก่าทั้งหมดก่อน
    //         foreach ($highlight->images as $image) {
    //             Storage::disk('public')->delete($image->image);
    //             $image->delete();
    //         }
            
    //         // อัปโหลดรูปใหม่
    //         foreach ($request->file('images') as $imageFile) {
    //             $image = $manager->read($imageFile->getPathname())
    //             ->scale(width: 1200)
    //             ->encode(new JpegEncoder(80));
                
    //             $fileName = 'imageCollection/' . uniqid() . '.jpg';
    //             Storage::disk('public')->put($fileName, $image->toString());
                
    //             ImageCollection::create([
    //                 'image' => $fileName,
    //                 'highlight_id' => $highlight->id,
    //             ]);
    //         }
    //     }
        
    //     Log::info('------=----5');
    //     return redirect()->route('highlights.index')->with('success', 'Highlight updated successfully!');
    // }

//     public function update(Request $request, $id)
// {
//     $request->validate([
//         'title' => 'required|string|max:255',
//         'category_id' => 'required|exists:category,id',
//         'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
//         'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
//     ]);

//     $highlight = Highlight::findOrFail($id);
//     $coverImagePath = $highlight->image;
    
//     // ✅ ลบรูปภาพที่ถูกเลือกให้ลบเมื่อกด "Update"
//     if ($request->deleted_images) {
//         $deletedImageIds = json_decode($request->deleted_images, true);
        
//         foreach ($deletedImageIds as $imageId) {
//             $image = ImageCollection::find($imageId);
//             if ($image) {
//                 Storage::disk('public')->delete($image->image);
//                 $image->delete();
//             }
//         }
//     }

//     // ✅ อัปเดต Cover Image
//     if ($request->hasFile('cover_image')) {
//         if ($highlight->image) {
//             Storage::disk('public')->delete($highlight->image);
//         }
//         $coverImagePath = $request->file('cover_image')->store('highlightImage', 'public');
//     }

//     // ✅ อัปเดตข้อมูล Highlight
//     $highlight->update([
//         'title' => $request->title,
//         'description' => $request->description,
//         'category_id' => $request->category_id,
//         'image' => $coverImagePath,
//     ]);

//     // ✅ อัปโหลดรูปใหม่ที่ถูกเพิ่มเข้ามา
//     if ($request->hasFile('images')) {
//         foreach ($request->file('images') as $imageFile) {
//             $fileName = $imageFile->store('imageCollection', 'public');

//             ImageCollection::create([
//                 'image' => $fileName,
//                 'highlight_id' => $highlight->id,
//             ]);
//         }
//     }

//     return redirect()->route('highlights.index')->with('success', 'Highlight updated successfully!');
// }

public function update(Request $request, $id)
{
    Log::info("🛠 UPDATE FUNCTION CALLED FOR HIGHLIGHT ID: " . $id);
    Log::info("🔍 REQUEST DATA:", $request->all());

    $request->validate([
        'title' => 'required|string|max:255',
        'category_id' => 'required|exists:category,id',
        'cover_image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
        'images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120',
    ]);

    Log::info('Starting update process...');
    $highlight = Highlight::findOrFail($id);
    $coverImagePath = $highlight->image;

    // ✅ Update Cover Image
    if ($request->hasFile('cover_image')) {
        if ($highlight->image) {
            Storage::disk('public')->delete($highlight->image);
        }
        $coverImagePath = $request->file('cover_image')->store('highlightImage', 'public');
    }

    // ✅ Update Highlight Data
    $highlight->update([
        'title' => $request->title,
        'description' => $request->description,
        'category_id' => $request->category_id,
        'image' => $coverImagePath,
    ]);

    // ✅ Remove images marked for deletion
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

    Log::info('Highlight updated successfully.');
    return redirect()->route('highlights.index')->with('success', 'Highlight updated successfully!');
}



    public function addToHighlights($id)
    {
        $highlight = Highlight::findOrFail($id);
        $highlight->status = 1;
        $highlight->save();

        return redirect()->route('highlights.index')->with('success', 'Added to Highlights!');
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

    public function deleteHighlightById($id)
    {
    $highlight = Highlight::findOrFail($id);

    // ลบข้อมูลใน ImageCollection ที่เกี่ยวข้อง
    foreach ($highlight->images as $image) {
        Storage::disk('public')->delete($image->image); // ลบไฟล์จาก storage
        $image->delete(); // ลบข้อมูลจาก database
    }

    // ลบ Highlight
    $highlight->delete();

    return redirect()->back()->with("success", "Highlight deleted successfully.");
    }

}
