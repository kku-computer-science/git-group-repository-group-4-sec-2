@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<div class="container">
    <h2>Create News</h2>
    <form action="{{ route('highlights.store') }}" method="POST" enctype="multipart/form-data">
        @csrf
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" class="form-control" name="title" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <select class="form-control" name="category_id" required>
                <option value="">Select Category</option>
                @foreach ($categories as $category)
                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                @endforeach
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Upload Image</label>
            <input type="file" class="form-control" name="image">
        </div>

        <button type="submit" class="btn btn-success">Create</button>
        <a href="{{ route('highlights.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>
@endsection
