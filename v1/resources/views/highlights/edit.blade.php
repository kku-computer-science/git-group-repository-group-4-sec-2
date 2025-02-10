@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<div class="container">
    <h2>Edit News</h2>
    <form action="{{ route('highlights.update', $highlight->id) }}" method="POST" enctype="multipart/form-data">
        @csrf @method('PUT')

        <!-- ✅ Cover Image -->
        <div class="mb-3">
            <label class="form-label">Cover Image</label>
            <input type="file" class="form-control" name="cover_image">
            @if($highlight->image)
            <p>Current Image:</p>
            <img src="{{ asset('storage/' . $highlight->image) }}" width="120">
            @endif
        </div>

        <!-- ✅ Title -->
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" class="form-control" name="title" value="{{ $highlight->title }}" required>
        </div>

        <!-- ✅ Category (Fixed Missing Category Input) -->
        <div class="mb-3">
            <label class="form-label">Category</label>
            <select class="form-control" name="category_id" required>
                <option value="">Select Category</option>
                @foreach ($categories as $category)
                <option value="{{ $category->id }}" {{ $highlight->category_id == $category->id ? 'selected' : '' }}>
                    {{ $category->name }}
                </option>
                @endforeach
            </select>
        </div>

        <!-- ✅ Image Album (Multiple) -->
        <div class="mb-3">
            <label class="form-label">Upload New Image Album</label>
            <input type="file" class="form-control" name="images[]" multiple id="imageAlbumInput">

            <div id="imageAlbumPreview" class="d-flex flex-wrap mt-2">
                @foreach ($highlight->images as $image)
                <div class="image-container" data-id="{{ $image->id }}">
                    <img src="{{ asset('storage/' . $image->image) }}" width="80">
                    <button type="button" class="btn btn-danger btn-sm remove-image" data-id="{{ $image->id }}">Remove</button>
                </div>
                @endforeach
            </div>
        </div>

        <!-- ✅ Hidden input to store image IDs that should be deleted -->
        <input type="hidden" name="deleted_images" id="deletedImagesInput" value="[]">

        <button type="submit" class="btn btn-success">Update</button>
        <a href="{{ route('highlights.index') }}" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<!-- ✅ JavaScript for Marking Images for Deletion -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        let deletedImages = [];

        document.querySelectorAll('.remove-image').forEach(button => {
            button.addEventListener('click', function() {
                const imageId = this.getAttribute('data-id');
                const container = this.closest('.image-container');

                // Add image ID to the delete list
                if (!deletedImages.includes(imageId)) {
                    deletedImages.push(imageId);
                }

                // Update hidden input field
                document.getElementById('deletedImagesInput').value = JSON.stringify(deletedImages);

                // Hide the image preview instead of deleting it immediately
                container.style.display = 'none';
            });
        });

        // ✅ Debugging: Check deleted images before submission
        document.querySelector('form').addEventListener('submit', function(event) {
            console.log("Submitting deletedImages:", document.getElementById('deletedImagesInput').value);
        });
    });
</script>

@endsection
