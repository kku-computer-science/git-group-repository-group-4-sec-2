<?php

namespace App\Http\Controllers;

use App\Models\ImageCollection;
use Illuminate\Http\Request;

class HighlightController extends Controller
{
    public function index()
    {
        return view('highlights.index');
    }

    public function create()
    {
        return view('highlights.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'category_id' => 'required|integer',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:png,jpg,jpeg,gif,svg|max:2048',
            'image_album.*' => 'nullable|image|mimes:png,jpg,jpeg,gif,svg|max:2048',
        ]);

        $highlight = new Highlight();
        $highlight->title = $request->title;
        $highlight->category_id = $request->category_id;
        $highlight->description = $request->description;
        $highlight->status = $request->status ?? 0;

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('highlight_images', 'public');
            $highlight->image = $imagePath;
        }

        $highlight->save();

        if ($request->hasFile('image_album')) {
            foreach ($request->file('image_album') as $imageFile) {
                $imagePath = $imageFile->store('highlight_albums', 'public');

                ImageCollection::create([
                    'highlight_id' => $highlight->id,
                    'image' => $imagePath
                ]);
            }
        }
        return redirect()->route('highlights.index')->with('success', 'Highlight created successfully.');
    }
}
// Compare this snippet from resources/views/highlights/index.blade.php: