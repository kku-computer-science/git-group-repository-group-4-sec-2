<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $table = 'category';
    protected $primaryKey = 'id';
    public $timestamps = true;

    protected $fillable = ['name'];

    // ความสัมพันธ์กับ Highlight
    public function highlights()
    {
        return $this->hasMany(Highlight::class, 'category_id');
    }
}
