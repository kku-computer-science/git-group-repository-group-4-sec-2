<?php

namespace App\Http\Controllers;

use App\Models\Highlight;
use Illuminate\Support\Facades\Log;


class HighlightdetailController extends Controller
{
    public function index()
    {
        $highlights = Highlight::with(['category:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->where('status', 1)
            ->get(['id', 'image', 'title', 'user_id', 'created_at', 'updated_at']); // 🔹 ลบ 'tag_id'

        $news = Highlight::whereNull('status')
            ->with(['tags:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->get(['id', 'image', 'title', 'user_id', 'created_at']);

        return view('highlightdetail.index', compact('highlights', 'news'));
    }

    public function show($id)
    {
        $highlights = Highlight::with(['category:id,name', 'user:id,fname_th,lname_th', 'images'])
            ->select(['id', 'image', 'title', 'description', 'category_id', 'user_id', 'created_at', 'updated_at'])
            ->where('id', $id)
            ->get();

        Log::info('1234');

        $highlight = Highlight::with(['category', 'user', 'images'])
            ->where('id', $id)
            ->firstOrFail();

        $news = Highlight::whereHas('tags', function ($q) use ($highlight) {
            $tagIds = $highlight->tags()->pluck('id')->toArray();
            if (!empty($tagIds)) {
                $q->whereIn('id', $tagIds);
            }
        })
            ->where('id', '!=', $id)
            ->select(['id', 'image', 'title', 'description', 'category_id', 'user_id', 'created_at'])
            ->get();

        return view('highlightdetail.index', compact('highlight', 'news')); // 🔹 เปลี่ยน highlights เป็น highlight
    }
}
