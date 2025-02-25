<?php

namespace App\Http\Controllers;

use App\Models\Highlight;
use App\Models\Tag;
use Illuminate\Http\Request;

class AllHighlightsController extends Controller
{
    // public function index()
    // {
    //     // ดึงข้อมูล Highlight พร้อมความสัมพันธ์ tags, user, images และเรียงลำดับล่าสุด
    //     $highlights = Highlight::with(['tags', 'user', 'images'])
    //                     ->latest()
    //                     ->paginate(10);

    //     // ดึงข้อมูล tag ทั้งหมด
    //     $tags = Tag::all();

    //     return view('allhighlights.index', compact('highlights', 'tags'));
    // }

    // public function index(Request $request)
    // {
    //     $query = Highlight::with(['tags', 'user', 'images'])->latest();

    //     if ($request->has('tag')) {
    //         $tag = strtolower(trim($request->tag));
    //         $query->whereHas('tags', function ($q) use ($tag) {
    //             $q->whereRaw('LOWER(name) = ?', [$tag]);
    //         });
    //     }

    //     $highlights = $query->paginate(10);
    //     $tags = Tag::all();

    //     return view('allhighlights.index', compact('highlights', 'tags'));
    // }

    public function index(Request $request)
    {
        $query = Highlight::with(['tags', 'user', 'images'])->latest();
    
        // ถ้ามีการส่งค่า tag มา ให้กรองเฉพาะ Highlights ที่มี tag นั้น ๆ
        if ($request->has('tag') && $request->tag !== 'all') {
            $query->whereHas('tags', function ($q) use ($request) {
                $q->where('name', $request->tag);
            });
        }
    
        $highlights = $query->paginate(10);
        $tags = Tag::all();
    
        return view('allhighlights.index', compact('highlights', 'tags'));
    }
    

    public function show($id)
    {
        // ดึงข้อมูล Highlight ที่มีความสัมพันธ์ tags, user, images ด้วย
        $highlight = Highlight::with(['tags', 'user', 'images'])->findOrFail($id);

        return view('allhighlights.show', compact('highlight'));
    }
}
