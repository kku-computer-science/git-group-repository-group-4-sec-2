<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Highlight;
use App\Models\Category;
use Illuminate\Support\Facades\Storage;

class HighlightController extends Controller
{
    public function index()
    {
        $highlights = Highlight::with(['category:id,name'])
                               ->where('status', 1)
                               ->get(['id', 'image', 'title', 'category_id', 'created_at']);

        $news = Highlight::whereNull('status')
                         ->with(['category:id,name'])
                         ->get(['id', 'image', 'title', 'category_id', 'created_at']);

        return view('highlights.index', compact('highlights', 'news'));
    }

    // 🔹 แสดงหน้าสร้าง News (Highlight)
    public function create()
    {
        $categories = Category::all();
        return view('highlights.create', compact('categories'));
    }

    // 🔹 บันทึก News (Highlight)
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'category_id' => 'required|exists:category,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('highlightImage', 'public');
        }

        Highlight::create([
            'title' => $request->title,
            'description' => $request->description,
            'category_id' => $request->category_id,
            'image' => $imagePath,
            'status' => null, // เมื่อสร้างใหม่จะอยู่ใน News ก่อน
        ]);

        return redirect()->route('highlights.index')->with('success', 'News created successfully!');
    }
}
