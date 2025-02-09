<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HighlightController extends Controller
{
    public function index()
    {
        return view('highlights.index');
    }
}
// Compare this snippet from resources/views/highlights/index.blade.php: