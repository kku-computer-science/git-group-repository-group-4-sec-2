<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    use HasFactory;

    protected $table = 'tag'; // ✅ ใช้ `tag` (ไม่มี `s`)
    protected $primaryKey = 'id';
    public $timestamps = false; // ✅ ไม่มี `created_at` และ `updated_at`

    protected $fillable = ['name'];

    public function highlights()
    {
        return $this->belongsToMany(Highlight::class, 'highlight_has_tag', 'tag_id', 'highlight_id');
    }
}