<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'category'; // ชื่อตารางในฐานข้อมูล
    protected $primaryKey = 'id';
    public $timestamps = false; // ไม่มี `created_at` และ `updated_at`

    protected $fillable = ['name'];

    // ความสัมพันธ์กับ Highlight (หนึ่ง Category มีหลาย Highlight)
    public function highlights()
    {
        return $this->hasMany(Highlight::class, 'category_id');
    }
}
