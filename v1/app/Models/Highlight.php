<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Highlight extends Model
{
    use HasFactory;

    protected $table = 'highlight'; // ชื่อตาราง
    protected $primaryKey = 'id'; // คีย์หลัก
    public $timestamps = true; // ถ้ามี `created_at` และ `updated_at`
    
    protected $fillable = ['image', 'title', 'description', 'status', 'category_id'];

    // ความสัมพันธ์กับ Category
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    // ความสัมพันธ์กับ ImageCollection
    public function images()
    {
        return $this->hasMany(ImageCollection::class, 'highlight_id');
    }
}
