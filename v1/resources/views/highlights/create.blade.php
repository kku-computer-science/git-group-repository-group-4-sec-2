@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<div class="container">
    <h2>Create News</h2>
    <form action="{{ route('highlights.store') }}" method="POST" enctype="multipart/form-data">
        @csrf

        <!-- Cover Image -->
        <div class="mb-3">
            <label class="form-label">Cover Image</label>
            <input type="file" class="form-control" name="cover_image" id="coverImageInput" accept="image/*">
            @error('cover_image')
            <small class="text-danger">{{ $message }}</small>
            @enderror
            <br>
            <img id="coverImagePreview" src="#" alt="Cover Image Preview" style="max-width: 100%; display: none;">
        </div>

        <!-- Title -->
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" class="form-control" name="title" required value="{{ old('title') }}">
            @error('title')
            <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>

        <!-- Description -->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description">{{ old('description') }}</textarea>
            @error('description')
            <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>

        <!-- Category -->
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select class="form-control" name="category_id" required>
                <option value="">Select Category</option>
                @foreach ($categories as $category)
                <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>
                    {{ $category->name }}
                </option>
                @endforeach
            </select>
            @error('category_id')
            <small class="text-danger">{{ $message }}</small>
            @enderror
        </div>

        <!-- Image Album -->
        <div class="mb-3">
            <label class="form-label">Upload Image Album (Multiple)</label>
            <input type="file" class="form-control" name="images[]" id="imageAlbumInput" multiple accept="image/*">
            @error('images')
            <small class="text-danger">{{ $message }}</small>
            @enderror
            <br>
            <div id="imageAlbumPreview" class="d-flex flex-wrap"></div>
        </div>

        <button type="submit" class="btn btn-success">Create</button>
        <a href="{{ route('highlights.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<!-- JavaScript for Image Preview -->
<script>
    document.getElementById('coverImageInput').addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('coverImagePreview').src = e.target.result;
                document.getElementById('coverImagePreview').style.display = 'block';
            };
            reader.readAsDataURL(file);
        }
    });

    document.getElementById('imageAlbumInput').addEventListener('change', function(event) {
        const files = event.target.files;
        const previewContainer = document.getElementById('imageAlbumPreview');
        previewContainer.innerHTML = ''; // เคลียร์รูปเก่าก่อน
        if (files) {
            Array.from(files).forEach(file => {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const imgElement = document.createElement('img');
                    imgElement.src = e.target.result;
                    imgElement.style.maxWidth = '100px';
                    imgElement.style.margin = '5px';
                    previewContainer.appendChild(imgElement);
                };
                reader.readAsDataURL(file);
            });
        }
    });
</script>
@endsection