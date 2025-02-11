@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="container">
    <div class="card p-4">
        <div class="card-body">
            <h4 class="card-title">Edit News</h4>
            <form id="updateForm" action="{{ route('highlights.update', $highlight->id) }}" method="POST" enctype="multipart/form-data">
                @csrf @method('PUT')

                <!-- ✅ Cover Image -->
                <div class="form-group">
                    <label for="cover_image">Cover Image</label>
                    <div class="image-upload-box" id="coverImageBox" onclick="document.getElementById('cover_image').click();">
                        <input type="file" name="cover_image" id="cover_image" class="d-none" accept="image/*" onchange="previewCoverImage(event)">
                        <div class="upload-placeholder" id="coverPlaceholder" style="{{ $highlight->image ? 'display: none;' : '' }}">
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>Click to upload an image</p>
                            </div>
                        </div>
                        <div class="image-preview {{ $highlight->image ? '' : 'd-none' }}" id="coverPreview">
                            <img id="coverPreviewImg" src="{{ asset('storage/' . $highlight->image) }}" alt="Cover Image">
                            <button type="button" class="close-btn" onclick="removeCoverImage(event)">✖</button>
                        </div>
                    </div>
                </div>

                <!-- ✅ Title -->
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" name="title" id="title" class="form-control" value="{{ $highlight->title }}" required>
                </div>

                <!-- ✅ Category -->
                <div class="form-group">
                    <label for="category">Category</label>
                    <select name="category_id" id="category" class="form-control" required>
                        <option value="">Select Category</option>
                        @foreach ($categories as $category)
                        <option value="{{ $category->id }}" {{ $highlight->category_id == $category->id ? 'selected' : '' }}>
                            {{ $category->name }}
                        </option>
                        @endforeach
                    </select>
                </div>

                <!-- ✅ Description -->
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea name="description" id="description" class="form-control description-box" rows="6">{{ $highlight->description }}</textarea>
                </div>

                <!-- ✅ Image Album -->
                <div class="form-group">
                    <label for="image_album">Image Album</label>
                    <div class="image-upload-box small" id="imageAlbumBox" onclick="document.getElementById('image_album').click();">
                        <input type="file" name="images[]" id="image_album" class="d-none" multiple accept="image/*">
                        <div class="upload-placeholder" >
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>Click to upload images</p>
                            </div>
                        </div>
                    </div>

                    <!-- ✅ แสดงรูปภาพทั้งหมด -->
                    <div id="albumPreview" class="album-preview mt-2">
                        @foreach ($highlight->images as $image)
                        <div class="image-item existing-image" data-id="{{ $image->id }}">
                            <img src="{{ asset('storage/' . $image->image) }}" alt="Album Image">
                            <button type="button" class="remove-btn" onclick="markImageForDeletion({{ $image->id }}, this)">✖</button>
                        </div>
                        @endforeach
                    </div>
                </div>

                <!-- ✅ Store Deleted Image IDs -->
                <input type="hidden" name="deleted_images" id="deletedImagesInput">

                <!-- ✅ Buttons -->
                <div class="form-group d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-light" onclick="confirmCancel()">Cancel</button>
                    <button type="button" class="btn btn-dark" onclick="confirmUpdate()">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    let deletedImages = [];
    let selectedFiles = [];

    function previewCoverImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("coverPreviewImg").src = e.target.result;
                document.getElementById("coverPlaceholder").style.display = "none"; // Hide placeholder
                document.getElementById("coverPreview").style.display = "block"; // Show preview
            };
            reader.readAsDataURL(file);
        }
    }


    // function removeCoverImage() {
    //     document.getElementById("cover_image").value = "";
    //     document.getElementById("coverPreview").classList.add("d-none");
    //     document.getElementById("coverPlaceholder").classList.remove("d-none");
    // }
    function removeCoverImage() {
        event.stopPropagation();
        document.getElementById("cover_image").value = ""; // Clear input
        document.getElementById("coverPreview").style.display = "none"; // Hide preview
        document.getElementById("coverPlaceholder").style.display = "flex"; // Show placeholder

        // ✅ Force-reset the input to ensure new selections trigger 'change' event
        let newInput = document.createElement("input");
        newInput.type = "file";
        newInput.name = "cover_image";
        newInput.id = "cover_image";
        newInput.className = "d-none";
        newInput.accept = "image/*";
        newInput.onchange = previewCoverImage;

        // Replace the old input
        document.getElementById("cover_image").replaceWith(newInput);
    }



    function markImageForDeletion(id, element) {
        deletedImages.push(id);
        document.getElementById('deletedImagesInput').value = JSON.stringify(deletedImages);
        element.parentElement.remove();
    }

    document.getElementById('image_album').addEventListener('change', function(event) {
        const newFiles = Array.from(event.target.files);
        selectedFiles = selectedFiles.concat(newFiles);
        updateAlbumPreview();
    });

    function updateAlbumPreview() {
        const previewContainer = document.getElementById('albumPreview');

        // ✅ ตรวจสอบว่ามีรูปเก่าอยู่แล้วหรือไม่ ถ้าไม่ให้ดึงข้อมูลใหม่
        if (!document.querySelector('.existing-image')) {
            document.querySelectorAll('.existing-image').forEach(existing => {
                previewContainer.appendChild(existing);
            });
        }

        // ✅ แสดงรูปที่เพิ่งเพิ่ม
        selectedFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const imgWrapper = document.createElement('div');
                imgWrapper.classList.add('image-item');

                const imgElement = document.createElement('img');
                imgElement.src = e.target.result;
                imgElement.alt = "Image Preview";

                const removeBtn = document.createElement('button');
                removeBtn.innerHTML = '✖';
                removeBtn.classList.add('remove-btn');
                removeBtn.onclick = function() {
                    removeImage(index);
                };

                imgWrapper.appendChild(imgElement);
                imgWrapper.appendChild(removeBtn);
                previewContainer.appendChild(imgWrapper);
            };
            reader.readAsDataURL(file);
        });

        const dt = new DataTransfer();
        selectedFiles.forEach(file => dt.items.add(file));
        document.getElementById("image_album").files = dt.files;
    }

    function removeImage(index) {
        selectedFiles.splice(index, 1);
        updateAlbumPreview();
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

    function confirmUpdate() {
        Swal.fire({
            title: "ยืนยันการอัปเดต?",
            text: "คุณแน่ใจหรือไม่ว่าต้องการอัปเดตข้อมูลนี้",
            icon: "question",
            showCancelButton: true,
            padding: "1.25rem",
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "ใช่, อัปเดตเลย!",
            cancelButtonText: "ยกเลิก"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("updateForm").submit();
            }
        });
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