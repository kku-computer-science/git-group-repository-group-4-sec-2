<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UsersHasRoles extends Model
{
    use HasFactory;

    protected $table = 'users_has_roles';
    public $timestamps = false;
    protected $fillable = ['users_id', 'roles_id'];

    public function user()
    {
        return $this->belongsTo(User::class, 'users_id');
    }

    public function role()
    {
        return $this->belongsTo(Role::class, 'roles_id');
    }
}
