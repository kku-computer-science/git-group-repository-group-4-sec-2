<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Highlight extends Model
{
    use HasFactory;

    protected $table = 'highlight';
    protected $primaryKey = 'id';
    public $timestamps = true;

    protected $fillable = [
        'image', 
        'title', 
        'description', 
        'status', 
        'user_id', 
        'priority', 
        'link'
    ];

    public function tags()
    {
        return $this->belongsToMany(Tag::class, 'highlight_has_tag', 'highlight_id', 'tag_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function images()
    {
        return $this->hasMany(ImageCollection::class, 'highlight_id');
    }
}