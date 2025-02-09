@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<div class="container">
    <div class="card" style="padding: 16px;">
        <div class="card-body">
            <h4 class="card-title">Create News</h4>
            <form action="{{ route('highlights.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <div class="form-group">
                    <label for="cover_image">Cover Image</label>
                    <div class="image-upload-box" id="coverImageBox">
                        <input type="file" name="cover_image" id="cover_image" class="d-none" accept="image/*" onchange="previewCoverImage(event)">

                        <!-- Placeholder for Upload -->
                        <div class="upload-placeholder" id="coverPlaceholder" onclick="document.getElementById('cover_image').click();">
                            <div class="icon">
                                <i class="mdi mdi-plus"></i>
                            </div>
                            <p>เพิ่มรูปภาพ</p>
                            <span>1234 × 4567</span>
                        </div>

                        <!-- Preview Area -->
                        <div class="image-preview d-none" id="coverPreview">
                            <img id="coverPreviewImg" src="" alt="Cover Image">
                            <button type="button" class="close-btn" onclick="removeCoverImage()">✖</button>
                        </div>
                    </div>
                </div>



                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" name="title" id="title" class="form-control" required>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select name="category" id="category" class="form-control">
                        <option value="">Select Category</option>
                        <!-- Add category options -->
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea name="description" id="description" class="form-control" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label for="image_album">Image Album</label>
                    <div class="image-upload-box" id="imageAlbumBox">
                        <input type="file" name="image_album[]" id="image_album" class="d-none" multiple accept="image/*" onchange="previewImageAlbum(event)">

                        <!-- Placeholder -->
                        <div class="upload-placeholder" onclick="document.getElementById('image_album').click();">
                            <div class="icon">
                                <i class="mdi mdi-plus"></i>
                            </div>
                            <p>เพิ่มรูปภาพ</p>
                            <span>1234 × 1234</span>
                        </div>
                    </div>

                    <!-- Preview Gallery -->
                    <div class="album-preview" id="albumPreview"></div>
                </div>

                <div class="form-group d-flex justify-content-end gap-2">
                    <button type="button" class="btn btn-light" onclick="confirmCancel()">Cancel</button>
                    <button type="submit" class="btn btn-dark">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function previewCoverImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("coverPreviewImg").src = e.target.result;
                document.getElementById("coverPlaceholder").classList.add("d-none");
                document.getElementById("coverPreview").classList.remove("d-none");
            };
            reader.readAsDataURL(file);
        }
    }

    function removeCoverImage() {
        document.getElementById("cover_image").value = "";
        document.getElementById("coverPreview").classList.add("d-none");
        document.getElementById("coverPlaceholder").classList.remove("d-none");
    }

    function previewImageAlbum(event) {
        const files = event.target.files;
        const albumPreview = document.getElementById("albumPreview");
        albumPreview.innerHTML = ""; // ล้างข้อมูลเก่าก่อน

        for (let i = 0; i < files.length; i++) {
            const file = files[i];
            const reader = new FileReader();

            reader.onload = function(e) {
                const imageItem = document.createElement("div");
                imageItem.classList.add("image-item");

                const img = document.createElement("img");
                img.src = e.target.result;

                const removeBtn = document.createElement("button");
                removeBtn.innerHTML = "✖";
                removeBtn.classList.add("remove-btn");
                removeBtn.onclick = function() {
                    removeImage(i);
                };

                imageItem.appendChild(img);
                imageItem.appendChild(removeBtn);
                albumPreview.appendChild(imageItem);
            };

            reader.readAsDataURL(file);
        }
    }

    function removeImage(index) {
        const input = document.getElementById("image_album");
        const dt = new DataTransfer();
        const files = input.files;

        for (let i = 0; i < files.length; i++) {
            if (i !== index) {
                dt.items.add(files[i]);
            }
        }

        input.files = dt.files;
        previewImageAlbum({
            target: {
                files: dt.files
            }
        });
    }


    function confirmCancel() {
        let confirmAction = confirm("คุณต้องการยกเลิกหรือไม่?");
        if (confirmAction) {
            window.location.href = "{{ route('highlights.index') }}";
        }
    }
</script>

<style>
    .image-upload-box {
        position: relative;
        width: 100%;
        max-width: 500px;
        height: 250px;
        background: #333;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        overflow: hidden;
    }

    .upload-placeholder {
        text-align: center;
        color: #fff;
        cursor: pointer;
    }

    .upload-placeholder .icon {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        padding: 10px;
        display: inline-block;
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
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        cursor: pointer;
        padding: 5px 10px;
        border-radius: 50%;
    }

    .album-preview {
        display: flex;
        flex-wrap: wrap;
        margin-top: 10px;
        gap: 10px;
    }

    .album-preview .image-item {
        position: relative;
        width: 100px;
        height: 100px;
        border-radius: 8px;
        overflow: hidden;
        background: #333;
    }

    .album-preview .image-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .album-preview .remove-btn {
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