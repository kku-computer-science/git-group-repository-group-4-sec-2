@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>


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
                    <label for="tag">Tags</label>
                    <select name="tag_id[]" id="tag" class="form-control select2" multiple="multiple">
                        @foreach ($categories as $tag)
                        <option value="{{ $tag->id }}" {{ in_array($tag->id, $selectedTags) ? 'selected' : '' }}>
                            {{ $tag->name }}
                        </option>
                        @endforeach
                    </select>
                </div>


                <!-- ✅ Description -->
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea name="description" id="description" class="form-control description-box" rows="6">{{ $highlight->description }}</textarea>
                </div>

                <div class="form-group">
                    <label for="research_link">Link Research</label>
                    <input type="url" class="form-control" name="link" value="{{ $highlight->link ?? '' }}" placeholder="Enter your link">
                </div>


                <!-- ✅ Image Album -->
                <div class="form-group">
                    <label for="image_album">Image Album</label>
                    <div class="image-upload-box small" id="imageAlbumBox" onclick="document.getElementById('image_album').click();">
                        <input type="file" name="images[]" id="image_album" class="d-none" multiple accept="image/*">
                        <div class="upload-placeholder">
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

<!-- Modal for Creating New Tag -->
<div class="modal fade" id="createTagModal" tabindex="-1" role="dialog" aria-labelledby="createTagLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Create New Tag</h5>
                <button type="button" class="close close-modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" id="newTagName" class="form-control" placeholder="Enter tag name">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light cancel-modal">Cancel</button>
                <button type="button" class="btn btn-dark" id="saveTagBtn">Create</button>
            </div>
        </div>
    </div>
</div>

<script>
// $(document).ready(function() {
//     $('.select2').select2({
//         placeholder: "Select tags",
//         tags: true,
//         tokenSeparators: [',', ' ']
//     });

//     let selectedTags = @json($selectedTags);

//     // ✅ ตั้งค่า Select2 ให้เลือก Tag ที่มีอยู่แล้ว
//     $('#tag').val(selectedTags).trigger('change');

//     // ✅ กดปุ่ม ✖ แล้วลบ Tag ออกจาก UI (แต่ยังไม่อัปเดต Database)
//     $(document).on('click', '.remove-tag', function() {
//         let tagId = $(this).data('id');

//         // ซ่อนจาก UI
//         $(this).parent().remove();

//         // อัปเดตค่าที่เลือกใน Select2 (ลบออก)
//         let tagSelect = $('#tag').val();
//         tagSelect = tagSelect.filter(id => id != tagId);
//         $('#tag').val(tagSelect).trigger('change');
//     });

//     // ✅ Show Create Tag Modal
//     $('#createTagBtn').click(function() {
//         $('#createTagModal').modal('show');
//     });

//     // ✅ Save New Tag
//     $('#saveTagBtn').click(function() {
//         let tagName = $('#newTagName').val().trim();
//         if (tagName === '') {
//             Swal.fire("Error", "Tag name cannot be empty!", "error");
//             return;
//         }

//         $.post("{{ route('tags.store') }}", {
//             name: tagName,
//             _token: '{{ csrf_token() }}'
//         }, function(response) {
//             if (response.success) {
//                 let newTagId = response.tag.id;
//                 let newTagOption = new Option(tagName, newTagId, true, true);
//                 $('#tag').append(newTagOption).trigger('change');
//                 $('#createTagModal').modal('hide');
//                 $('#newTagName').val('');
//             } else {
//                 Swal.fire("Error", response.message, "error");
//             }
//         }).fail(function() {
//             Swal.fire("Error", "Failed to create tag", "error");
//         });
//     });

   
// });

$(document).ready(function() {
    $('.select2').select2({
        placeholder: "Select tags or create new ones",
        tags: true, // อนุญาตให้เพิ่มแท็กใหม่
        tokenSeparators: [',', ' '],
        createTag: function(params) {
            var term = $.trim(params.term);
            if (term === "") {
                return null;
            }
            return {
                id: term, // ใช้ชื่อแท็กเป็น ID ชั่วคราว
                text: term,
                newTag: true
            };
        }
    });
    
    // ตั้งค่า Select2 ให้เลือก Tag ที่มีอยู่แล้ว
    let selectedTags = @json($selectedTags);
    $('#tag').val(selectedTags).trigger('change');
    
    let newTags = {}; // เก็บ {ชื่อแท็ก: ID จริง}

    // เมื่อสร้างแท็กใหม่ -> ส่งไปยังเซิร์ฟเวอร์เพื่อสร้างและรับ ID จริง
    $('#tag').on('select2:select', function(e) {
        var data = e.params.data;
        if (data.newTag) {
            $.ajax({
                type: "POST",
                url: "{{ route('tags.store') }}",
                data: {
                    name: data.text,
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    if (response.success) {
                        console.log("New Tag Created: ", response.tag); // Debugging Log

                        newTags[data.text] = response.tag.id; // เก็บ ID จริง

                        // ดึงค่า tags ที่เลือกทั้งหมดปัจจุบัน
                        let currentValues = $('#tag').val() || [];
                        
                        // แทนที่ค่า tag ที่เพิ่งสร้างด้วย ID จริง
                        let updatedValues = currentValues.map(val => 
                            val === data.text ? response.tag.id.toString() : val
                        );

                        // เพิ่มตัวเลือกใหม่ที่เป็น ID จริงเข้าไปใน dropdown
                        let newOption = new Option(response.tag.name, response.tag.id, false, false);
                        $('#tag').append(newOption);
                        
                        // อัปเดตค่าที่เลือก (โดยไม่รีเซ็ตตัวเลือกเดิม)
                        $('#tag').val(updatedValues).trigger('change');
                    }
                },
                error: function() {
                    Swal.fire("Error", "Failed to create tag", "error");
                }
            });
        }
    });

    // ก่อนส่งฟอร์ม -> แทนที่ชื่อแท็กเป็น ID จริง
    $('#updateForm').submit(function(event) {
        let selectedTags = $('#tag').val() || [];
        console.log("Before Conversion: ", selectedTags); // Debugging Log

        let updatedTags = selectedTags.map(tag => newTags[tag] || tag); // ถ้ามี ID จริง ใช้ ID แทน

        console.log("After Conversion: ", updatedTags); // Debugging Log

        $('#tag').val(updatedTags).trigger('change'); // อัปเดตค่าใน <select>

        return true; // อนุญาตให้ฟอร์มส่ง
    });
});

 // ✅ Confirm Update
 window.confirmUpdate = function() {
        Swal.fire({
            title: "ยืนยันการอัปเดต?",
            text: "คุณแน่ใจหรือไม่ว่าต้องการอัปเดตข้อมูลนี้",
            padding: "1.25rem",
            icon: "question",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "ใช่, อัปเดตเลย!",
            cancelButtonText: "ยกเลิก"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("updateForm").submit();
            }
        });
    };










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


    // ลบรูปเก่า
    function markImageForDeletion(id, element) {
        deletedImages.push(id); // เก็บ id ของรูปเก่าที่จะลบ
        document.getElementById('deletedImagesInput').value = JSON.stringify(deletedImages);
        element.parentElement.remove(); // ลบออกจากหน้า
    }
    document.getElementById('image_album').addEventListener('change', function(event) {
        const newFiles = Array.from(event.target.files);
        selectedFiles = selectedFiles.concat(newFiles);
        updateAlbumPreview();
    });


    function updateAlbumPreview() {
        const previewContainer = document.getElementById('albumPreview');

        // ✅ ล้างเฉพาะรูปใหม่ ไม่แตะรูปเก่า (existing-image)
        previewContainer.querySelectorAll('.image-item:not(.existing-image)').forEach(el => el.remove());

        // ✅ แสดงรูปใหม่
        selectedFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = function(e) {
                const imgWrapper = document.createElement('div');
                imgWrapper.classList.add('image-item');

                const imgElement = document.createElement('img');
                imgElement.src = e.target.result;
                imgElement.alt = "New Image Preview";

                const removeBtn = document.createElement('button');
                removeBtn.innerHTML = '✖';
                removeBtn.classList.add('remove-btn');
                removeBtn.onclick = function() {
                    removeNewImage(index);
                };

                imgWrapper.appendChild(imgElement);
                imgWrapper.appendChild(removeBtn);
                previewContainer.appendChild(imgWrapper);
            };
            reader.readAsDataURL(file);
        });

        // ✅ อัปเดตไฟล์ใน input type="file"
        const dt = new DataTransfer();
        selectedFiles.forEach(file => dt.items.add(file));
        document.getElementById('image_album').files = dt.files;
    }

    // ลบรูปใหม่
    function removeNewImage(index) {
        selectedFiles.splice(index, 1); // เอารูปใหม่ออกจาก array
        updateAlbumPreview(); // รีเฟรชตัวอย่าง
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

    .select2-selection--multiple {
        border: 1px solid #d1c7bd !important;
        border-radius: 10px !important;
        min-height: 50px !important;
    }

    .select2-selection__choice {
        color: #fff !important;
        border: none !important;
        ;
        border-radius: 25px !important;
        padding: 8px 25px !important;
        font-size: 14px !important;
    }

    .select2-selection__choice__remove {
        color: #fff !important;
        font-size: 20px !important;
        margin: 5px !important;
    }
</style>
@endsection