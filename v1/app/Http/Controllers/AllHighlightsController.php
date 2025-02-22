<?php

namespace App\Http\Controllers;

use App\Models\Highlight;
use App\Models\Tag;
use App\Models\ImageCollection;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;


class AllHighlightsController extends Controller
{
    public function index()
    {
        $highlights = Highlight::latest()->paginate(10);
        return view('allhighlights.index', compact('highlights'));
    }

    public function show($id)
    {
        $highlight = Highlight::findOrFail($id);
        return view('allhighlights.show', compact('highlight'));
    }
}
