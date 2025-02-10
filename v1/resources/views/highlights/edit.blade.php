@extends('dashboards.users.layouts.user-dash-layout')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


@section('content')
<div class="container">
    <div class="card" style="padding: 16px;">
        <div class="card-body">
            <h4 class="card-title">Edit News</h4>
            <form action="{{ route('highlights.update', $highlight->id) }}" method="POST" enctype="multipart/form-data">
                @csrf @method('PUT')

                <div class="form-group">
                    <label for="cover_image">Cover Image</label>
                    <div class="image-upload-box" id="coverImageBox" onclick="document.getElementById('cover_image').click();">
                        <input type="file" name="cover_image" id="cover_image" class="d-none" accept="image/*" onchange="previewCoverImage(event)">

                        <!-- Improved Placeholder -->
                        <div class="upload-placeholder" id="coverPlaceholder" style="{{ $highlight->image ? 'display: none;' : '' }}">
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>คลิกเพื่อเพิ่มรูปภาพ</p>
                            </div>
                        </div>

                        <!-- Image Preview -->
                        <div class="image-preview" id="coverPreview" style="{{ $highlight->image ? '' : 'display: none;' }}">
                            <img id="coverPreviewImg" src="{{ $highlight->image ? asset('storage/' . $highlight->image) : '' }}" alt="Cover Image">
                            <button type="button" class="close-btn" onclick="removeCoverImage(event)">✖</button>
                        </div>
                    </div>
                </div>



                <div class="form-group
                    <label for=" title">Title</label>
                    <input type="text" name="title" id="title" class="form-control" value="{{ $highlight->title }}" required>
                </div>

                <div class="form-group
                    <label for=" category">Category</label>
                    <select name="category_id" id="category" class="form-control" required>
                        <option value="">Select Category</option>
                        @foreach ($categories as $category)
                        <option value="{{ $category->id }}" {{ $highlight->category_id == $category->id ? 'selected' : '' }}>
                            {{ $category->name }}
                        </option>
                        @endforeach
                    </select>

                </div>

                <div class="form-group
                    <label for=" description">Description</label>
                    <textarea name="description" id="description" class="form-control description-box" rows="6">{{ $highlight->description }}</textarea>
                </div>

                <div class="form-group">
                    <label for="image_album">Image Album</label>
                    <div class="image-upload-box small" id="albumImageBox" onclick="document.getElementById('image_album').click();">
                        <input type="file" name="images[]" id="image_album" class="d-none" multiple onchange="previewAlbumImages(event)">
                        <div class="upload-placeholder" id="albumPlaceholder">
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>คลิกเพื่อเพิ่มรูปภาพ</p>
                            </div>
                        </div>
                    </div>
                    <div class="album-preview" id="imageAlbumPreview">
                        @foreach ($highlight->images as $image)
                        <div class="image-item" data-id="{{ $image->id }}">
                            <img src="{{ asset('storage/' . $image->image) }}">
                            <button type="button" class="remove-btn" onclick="removeAlbumImage({{ $image->id }}, this)">✖</button>
                        </div>
                        @endforeach
                    </div>
                    <button id="RemoveallBtn" type="button" class="btn btn-danger mt-2 d-none" style="margin-top: 1.25rem;" onclick="removeAllAlbumImages()">Remove All</button>
                </div>

                <div class="form-group d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-light" onclick="confirmCancel()">Cancel</button>
                    <button type="submit" class="btn btn-dark">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>

<!-- JavaScript for Image Preview & Delete -->
<script>
    function previewCoverImage(event) {
        const input = event.target;
        const reader = new FileReader();

        reader.onload = function() {
            document.getElementById('coverPreviewImg').src = reader.result;
            document.getElementById('coverPreview').style.display = "block";
            document.getElementById('coverPlaceholder').style.display = "none";
        };

        if (input.files && input.files[0]) {
            reader.readAsDataURL(input.files[0]);
        }
    }

    function removeCoverImage(event) {
        event.stopPropagation(); // Prevent triggering file selection when clicking delete

        document.getElementById('cover_image').value = "";
        document.getElementById('coverPreview').style.display = "none";
        document.getElementById('coverPreviewImg').src = "";
        document.getElementById('coverPlaceholder').style.display = "flex";
    }


    function confirmCancel() {
        Swal.fire({
            title: "คุณแน่ใจหรือไม่?",
            text: "หากยกเลิก ข้อมูลที่กรอกจะหายไป",
            icon: "warning",
            padding: "1.25rem",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "ใช่, ยกเลิกเลย!",
            cancelButtonText: "ไม่, กลับไปแก้ไข"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "{{ route('highlights.index') }}";
            }
        });
    }

    function previewAlbumImages(event) {
        const previewContainer = document.getElementById('imageAlbumPreview');
        for (const file of event.target.files) {
            const reader = new FileReader();
            reader.onload = function(e) {
                const div = document.createElement('div');
                div.classList.add('image-item');
                div.innerHTML = `<img src="${e.target.result}"><button type='button' class='remove-btn' onclick='this.parentElement.remove()'>✖</button>`;
                previewContainer.appendChild(div);
            };
            reader.readAsDataURL(file);
        }
    }

    function removeAlbumImage(id, element) {
        fetch(`/highlights/image-collection/${id}`, {
                method: 'DELETE',
                headers: {
                    'X-CSRF-TOKEN': '{{ csrf_token() }}',
                    'Accept': 'application/json'
                }
            }).then(response => response.json())
            .then(data => {
                if (data.success) {
                    element.parentElement.remove();
                } else {
                    alert('Failed to delete image.');
                }
            }).catch(error => console.error('Error:', error));
    }

    function toggleRemoveButton() {
        const removeBtn = document.getElementById('removeBtn');
        const images = document.querySelectorAll('.album-image'); // Adjust the selector based on your image class

        if (images.length > 0) {
            removeBtn.classList.remove('d-none');
        } else {
            removeBtn.classList.add('d-none');
        }
    }

 function removeAllAlbumImages() {
        document.querySelectorAll('.album-image').forEach(img => img.remove());
        toggleRemoveButton(); // Hide button after removing images
    }
}

</script>
<style>
    .image-upload-box.small {
        max-width: 200px;
        height: 100px;
    }

    .description-box {
        height: 200px;
        resize: vertical;
        border-radius: 8px;
        padding: 10px;
        font-size: 16px;
    }

    .image-upload-box {
        position: relative;
        width: 100%;
        max-width: 500px;
        height: 250px;
        background: #f3f3f3;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        overflow: hidden;
        border: 2px dashed #aaa;
        cursor: pointer;
    }

    .upload-placeholder {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        color: #666;
    }

    .placeholder-content {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .placeholder-content i {
        font-size: 40px;
        color: #999;
        margin-bottom: 8px;
    }

    .placeholder-content p {
        font-size: 14px;
        color: #777;
    }

    .image-preview {
        position: relative;
        width: 100%;
        height: 100%;
    }

    .image-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        background: rgba(0, 0, 0, 0.6);
        color: white;
        border: none;
        cursor: pointer;
        padding: 5px 10px;
        border-radius: 50%;
        font-size: 14px;
    }

    .album-preview {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 10px;
    }

    .image-item {
        position: relative;
        width: 120px;
        height: 120px;
        border-radius: 8px;
        overflow: hidden;
        background: #333;
    }

    .image-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .remove-btn {
        position: absolute;
        top: 5px;
        right: 5px;
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        cursor: pointer;
        padding: 5px;
        border-radius: 50%;
        font-size: 12px;
    }
</style>

@endsection