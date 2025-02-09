<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ImageCollection extends Model
{
    use HasFactory;

    protected $table = 'image_collection';
    protected $primaryKey = 'id';
    public $timestamps = true;

    protected $fillable = ['image', 'highlight_id'];

    // ความสัมพันธ์กับ Highlight
    public function highlight()
    {
        return $this->belongsTo(Highlight::class, 'highlight_id');
    }
}
