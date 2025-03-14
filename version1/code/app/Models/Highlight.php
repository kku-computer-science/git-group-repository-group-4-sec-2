<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Highlight extends Model
{
    use HasFactory;

    protected $table = 'highlight';
    protected $primaryKey = 'id';
    public $timestamps = true; // มี `created_at` และ `updated_at`

    protected $fillable = ['image', 'title', 'description', 'status', 'category_id', 'user_id'];

    // ความสัมพันธ์กับ Category (Highlight หนึ่งอันมีหนึ่ง Category)
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    // ความสัมพันธ์กับ User (Highlight หนึ่งอันถูกสร้างโดยหนึ่ง User)
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    // ความสัมพันธ์กับ ImageCollection (Highlight หนึ่งอันมีหลาย ImageCollection)
    public function images()
    {
        return $this->hasMany(ImageCollection::class, 'highlight_id');
    }
}
