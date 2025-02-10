<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RolePermissionSeeder extends Seeder
{
    public function run()
    {
        // ✅ สร้าง Permission (ถ้ายังไม่มี)
        Permission::findOrCreate('manage-highlights');

        // ✅ ให้ Role 'staff' และ 'admin' มีสิทธิ์นี้
        $staff = Role::findOrCreate('staff');
        $staff->givePermissionTo('manage-highlights');

        $admin = Role::findOrCreate('admin');
        $admin->givePermissionTo('manage-highlights');

        echo "✅ Permission และ Role ถูกอัปเดตเรียบร้อย!\n";
    }
}
