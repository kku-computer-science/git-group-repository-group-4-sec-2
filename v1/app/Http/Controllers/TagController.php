<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tag;

class TagController extends Controller
{
    // ✅ ฟังก์ชันสร้าง Tag ใหม่
    public function store(Request $request)
    {
        $request->validate(['name' => 'required|string|max:255']);

        // ตรวจสอบว่ามี Tag นี้อยู่แล้วหรือไม่
        $existingTag = Tag::where('name', $request->name)->first();
        if ($existingTag) {
            return response()->json(['success' => false, 'message' => 'Tag นี้มีอยู่แล้ว'], 409);
        }

        $tag = Tag::create(['name' => $request->name]);
        return response()->json(['success' => true, 'tag' => $tag]);
    }

    // ✅ ฟังก์ชันลบ Tag (เฉพาะ Tag ที่ไม่มีการใช้งาน)
    public function destroy($id)
    {
        $tag = Tag::find($id);

        if (!$tag) {
            return response()->json(['success' => false, 'message' => 'ไม่พบ Tag นี้'], 404);
        }

        // เช็คว่า Tag นี้ถูกใช้งานอยู่หรือไม่
        if ($tag->highlights()->exists()) {
            return response()->json([
                'success' => false,
                'message' => 'ไม่สามารถลบ Tag ที่ถูกใช้งานอยู่ได้'
            ], 400);
        }

        $tag->delete();

        return response()->json(['success' => true, 'message' => 'ลบ Tag สำเร็จ']);
    }
}
