<?php

namespace App\Http\Controllers;

use App\Models\Highlight;
use App\Models\Tag;
use App\Models\ImageCollection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;


class HighlightdetailController extends Controller
{
    public function index()
    {
        $highlights = Highlight::with(['tags:id,name', 'user:id,fname_th,lname_th', 'images']) // 🔹 เปลี่ยน tag เป็น tags
            ->where('status', 1)
            ->get(['id', 'image', 'title', 'user_id', 'created_at', 'updated_at']); // 🔹 ลบ 'tag_id'

        $news = Highlight::whereNull('status')
            ->with(['tags:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->get(['id', 'image', 'title', 'user_id', 'created_at']);

        return view('highlightdetail.index', compact('highlights', 'news'));
    }

    public function show($id)
    {
        $highlight = Highlight::with(['tags', 'user', 'images']) // 🔹 ใช้ tags แทน tag
            ->where('id', $id)
            ->firstOrFail();

        $news = Highlight::whereHas('tags', function ($q) use ($highlight) {
            $tagIds = $highlight->tags()->pluck('id')->toArray();
            if (!empty($tagIds)) {
                $q->whereIn('id', $tagIds);
            }
        })
            ->where('id', '!=', $id)
            ->select(['id', 'image', 'title', 'description', 'user_id', 'created_at'])
            ->get();

        return view('highlightdetail.index', compact('highlight', 'news')); // 🔹 เปลี่ยน highlights เป็น highlight
    }
}
