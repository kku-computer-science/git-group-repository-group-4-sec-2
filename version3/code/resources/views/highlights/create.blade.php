@extends('dashboards.users.layouts.user-dash-layout')

@section('content')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/heic2any@0.0.3/dist/heic2any.min.js"></script> -->
<script src="https://unpkg.com/heic2any@0.0.3/dist/heic2any.min.js"></script>


<div class="container">
    <div class="card" style="padding: 16px;">
        <div class="card-body">
            <h4 class="card-title">Create Highlight</h4>
            <form id="newsForm" action="{{ route('highlights.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <div class="form-group">
                    <label for="cover_image">Cover Image</label>
                    <div class="image-upload-box" id="coverImageBox" onclick="document.getElementById('cover_image').click();">
                        <input type="file" name="cover_image" id="cover_image" class="d-none" accept="image/*" onchange="previewCoverImage(event)">
                        <div class="upload-placeholder" id="coverPlaceholder">
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>คลิกเพื่อเพิ่มรูปภาพ</p>
                            </div>
                        </div>
                        <div class="image-preview d-none" id="coverPreview">
                            <img id="coverPreviewImg" src="#" alt="Cover Image">
                            <button type="button" class="close-btn" onclick="removeCoverImage()">✖</button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" name="title" id="title" class="form-control" placeholder="Enter the title">
                </div>

                <div class="form-group">
                    <label for="tag">Tags</label>

                    <select name="tag_id[]" id="tag" class="form-control select2" multiple="multiple">
                        @foreach ($categories as $tag)
                        <option value="{{ $tag->id }}">
                            {{ $tag->name }}
                        </option>
                        @endforeach
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea name="description" id="description" class="form-control description-box" rows="6" placeholder="Enter description"></textarea>
                </div>

                <div class="form-group">
                    <label for="research_link">Addtional Link</label>
                    <input type="url" class="form-control" id="link" name="link" placeholder="Enter the link">
                </div>

                <div class="form-group">
                    <label for="image_album">Related Images</label>
                    <div class="image-upload-box small" id="imageAlbumBox" onclick="document.getElementById('image_album').click();">
                        <input type="file" name="images[]" id="image_album" class="d-none" multiple accept="image/*">
                        <div class="upload-placeholder" id="albumPlaceholder">
                            <div class="placeholder-content">
                                <i class="mdi mdi-cloud-upload-outline"></i>
                                <p>คลิกเพื่อเพิ่มรูปภาพ</p>
                            </div>
                        </div>
                    </div>
                    <div id="albumPreview" class="album-preview"></div>
                    <button type="button" id="clearAllBtn" class="btn btn-danger d-none" style="margin-top: 1.25rem;" onclick="clearAllImages()">Clear All</button>
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
    // $(document).ready(function() {
    //     $('.select2').select2({
    //         placeholder: "Select tags",
    //         tags: true,
    //         tokenSeparators: [',', ' ']
    //     });

    //     // Show create tag modal
    //     $('#createTagBtn').click(function() {
    //         $('#createTagModal').modal('show');
    //     });

    //     // Handle Cancel button with SweetAlert
    //     $(document).on('click', '.cancel-modal, .close-modal', function() {
    //         Swal.fire({
    //             title: "Are you sure?",
    //             text: "Your input will be lost!",
    //             icon: "warning",
    //             showCancelButton: true,
    //             confirmButtonColor: "#d33",
    //             cancelButtonColor: "#3085d6",
    //             confirmButtonText: "Yes, cancel!",
    //             cancelButtonText: "No, keep editing"
    //         }).then((result) => {
    //             if (result.isConfirmed) {
    //                 $('#createTagModal').modal('hide'); // ปิด Modal
    //                 $('#newTagName').val(''); // เคลียร์ input
    //             }
    //         });
    //     });

    //     // Save new tag
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

                            // เก็บรายการแท็กทั้งหมดที่เลือกอยู่ในปัจจุบัน
                            let currentValues = $('#tag').val() || [];

                            // ลบตัวเลือกที่เป็นชื่อแท็กชั่วคราว
                            $('#tag option[value="' + data.text + '"]').remove();

                            // เพิ่มตัวเลือกใหม่ที่เป็น ID จริง
                            let newOption = new Option(response.tag.name, response.tag.id, false, true);
                            $('#tag').append(newOption);

                            // แทนที่ค่า tag ที่เพิ่งสร้างด้วย ID จริงในรายการ values
                            let updatedValues = currentValues.map(val =>
                                val === data.text ? response.tag.id.toString() : val
                            );

                            // อัปเดตค่าให้ Select2 โดยยังคงเก็บแท็กอื่นๆ ที่เลือกไว้
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
        $('#newsForm').submit(function(event) {
            let selectedTags = $('#tag').val() || [];
            console.log("Before Conversion: ", selectedTags); // Debugging Log

            let updatedTags = selectedTags.map(tag => newTags[tag] || tag); // ถ้ามี ID จริง ใช้ ID แทน

            console.log("After Conversion: ", updatedTags); // Debugging Log

            $('#tag').val(updatedTags).trigger('change'); // อัปเดตค่าใน <select>

            return true; // อนุญาตให้ฟอร์มส่ง
        });
    });

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

    // function previewCoverImage(event) {
    //     const file = event.target.files[0];
    //     if (file) {
    //         const reader = new FileReader();
    //         reader.onload = function(e) {
    //             document.getElementById("coverPreviewImg").src = e.target.result;
    //             document.getElementById("coverPlaceholder").classList.add("d-none");
    //             document.getElementById("coverPreview").classList.remove("d-none");
    //         };
    //         reader.readAsDataURL(file);
    //     }
    // }

    function previewCoverImage(event) {
        const file = event.target.files[0];
        if (!file) return;

        const fileType = file.type.toLowerCase();
        const validImageTypes = ["image/jpeg", "image/png", "image/gif", "image/webp"];

        if (validImageTypes.includes(fileType)) {
            // ✅ แสดงตัวอย่างรูปที่รองรับ
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("coverPreviewImg").src = e.target.result;
                document.getElementById("coverPlaceholder").classList.add("d-none");
                document.getElementById("coverPreview").classList.remove("d-none");
            };
            reader.readAsDataURL(file);
        } else if (fileType === "image/heic" || file.name.toLowerCase().endsWith(".heic")) {
            // ❌ แจ้งเตือนห้ามอัปโหลด HEIC
            Swal.fire({
                icon: "error",
                title: "ไม่สามารถอัปโหลดไฟล์ HEIC ได้!",
                text: "กรุณาใช้ไฟล์ JPG, PNG, GIF หรือ WEBP เท่านั้น",
                confirmButtonColor: "#d33",
                confirmButtonText: "ตกลง",
            });

            event.target.value = ""; // ❌ เคลียร์ input file
        } else {
            // ❌ แจ้งเตือนรูปแบบไฟล์ไม่รองรับ
            Swal.fire({
                icon: "error",
                title: "ประเภทไฟล์ไม่รองรับ!",
                text: "กรุณาอัปโหลดไฟล์ JPG, PNG, GIF หรือ WEBP เท่านั้น",
                confirmButtonColor: "#d33",
                confirmButtonText: "ตกลง",
            });

            event.target.value = ""; // ❌ เคลียร์ input file
        }
    }

    function removeCoverImage() {
        document.getElementById("cover_image").value = "";
        document.getElementById("coverPreview").classList.add("d-none");
        document.getElementById("coverPlaceholder").classList.remove("d-none");
    }

    let selectedFiles = []; // Store selected images

    // document.getElementById('image_album').addEventListener('change', function(event) {
    //     const newFiles = Array.from(event.target.files);
    //     selectedFiles = selectedFiles.concat(newFiles); // Append new images
    //     updateAlbumPreview();
    // });

    // function updateAlbumPreview() {
    //     const previewContainer = document.getElementById('albumPreview');
    //     previewContainer.innerHTML = ''; // Clear the UI, not the file list

    //     if (selectedFiles.length > 0) {
    //         document.getElementById("clearAllBtn").classList.remove("d-none"); // Show "Clear All" button
    //     } else {
    //         document.getElementById("clearAllBtn").classList.add("d-none"); // Hide when no images
    //     }

    //     selectedFiles.forEach((file, index) => {
    //         const reader = new FileReader();
    //         reader.onload = function(e) {
    //             const imgWrapper = document.createElement('div');
    //             imgWrapper.classList.add('image-item');

    //             const imgElement = document.createElement('img');
    //             imgElement.src = e.target.result;
    //             imgElement.alt = "Image Preview";

    //             const removeBtn = document.createElement('button');
    //             removeBtn.innerHTML = '✖';
    //             removeBtn.classList.add('remove-btn');
    //             removeBtn.onclick = function() {
    //                 removeImage(index);
    //             };

    //             imgWrapper.appendChild(imgElement);
    //             imgWrapper.appendChild(removeBtn);
    //             previewContainer.appendChild(imgWrapper);
    //         };
    //         reader.readAsDataURL(file);
    //     });

    //     const dt = new DataTransfer();
    //     selectedFiles.forEach(file => dt.items.add(file));
    //     document.getElementById("image_album").files = dt.files;
    // }

    // function removeImage(index) {
    //     selectedFiles.splice(index, 1);
    //     updateAlbumPreview();
    // }

    // function clearAllImages() {
    //     selectedFiles = [];
    //     document.getElementById("image_album").value = "";
    //     updateAlbumPreview();
    // }

    document.getElementById('image_album').addEventListener('change', function(event) {
        const newFiles = Array.from(event.target.files);

        newFiles.forEach(file => {
            const fileType = file.type.toLowerCase();
            if (fileType === "image/heic" || file.name.toLowerCase().endsWith(".heic")) {
                // ❌ แจ้งเตือนห้ามอัปโหลด HEIC
                Swal.fire({
                    icon: "error",
                    title: "ไม่สามารถอัปโหลดไฟล์ HEIC ได้!",
                    text: "กรุณาใช้ไฟล์ JPG, PNG, GIF หรือ WEBP เท่านั้น",
                    confirmButtonColor: "#d33",
                    confirmButtonText: "ตกลง",
                });
            } else {
                // ✅ อนุญาตให้เพิ่มลงในรายการ
                selectedFiles.push(file);
            }
        });

        updateAlbumPreview();
    });

    function updateAlbumPreview() {
        const previewContainer = document.getElementById('albumPreview');
        previewContainer.innerHTML = ''; // เคลียร์ UI แต่ไม่ลบไฟล์ที่เลือกไปแล้ว

        if (selectedFiles.length > 0) {
            document.getElementById("clearAllBtn").classList.remove("d-none"); // แสดงปุ่ม Clear All
        } else {
            document.getElementById("clearAllBtn").classList.add("d-none"); // ซ่อนปุ่มเมื่อไม่มีรูป
        }

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

    function clearAllImages() {
        selectedFiles = [];
        document.getElementById("image_album").value = "";
        updateAlbumPreview();
    }

    document.getElementById("newsForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent immediate form submission

        let title = document.getElementById("title").value;
        let tag = document.getElementById("tag").value;
        let coverPreview = document.getElementById("coverPreview").classList.contains("d-none");
        let description = document.getElementById("description").value;

        if (coverPreview) {
            Swal.fire({
                icon: "warning",
                title: "กรุณาอัปโหลดรูปภาพ!",
                text: "คุณต้องเลือกอัปโหลดรูปภาพก่อนส่งแบบฟอร์ม",
                padding: "1.25rem",
                confirmButtonText: "ตกลง",
                confirmButtonColor: "#3085d6",
            });
        } else if (!title) {
            Swal.fire({
                icon: "warning",
                title: "กรุณากรอกชื่อไฮไลท์!",
                text: "คุณต้องกรอกชื่อไฮไลท์ก่อนส่งแบบฟอร์ม",
                padding: "1.25rem",
                confirmButtonText: "ตกลง",
                confirmButtonColor: "#3085d6",
            });
        } else if (!tag) {
            Swal.fire({
                icon: "warning",
                title: "กรุณาเลือก tag!",
                text: "คุณต้องเลือก tag ก่อนส่งแบบฟอร์ม",
                padding: "1.25rem",
                confirmButtonText: "ตกลง",
                confirmButtonColor: "#3085d6",
            });
        } else if (!description) {
            Swal.fire({
                icon: "warning",
                title: "กรุณากรอกคำอธิบาย!",
                text: "คุณต้องกรอกคำอธิบายก่อนส่งแบบฟอร์ม",
                padding: "1.25rem",
                confirmButtonText: "ตกลง",
                confirmButtonColor: "#3085d6",
            });
        } else {
            confirmCreate();
        }

    });

    function confirmCreate() {
        Swal.fire({
            position: "center",
            icon: "success",
            title: "สร้าง Highlight สำเร็จ",
            showConfirmButton: false,
            timer: 1500
        }).then(() => {
            document.getElementById("newsForm").submit(); // Submit the form after SweetAlert closes
        });
    }
</script>

<style>
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

    .image-upload-box.small {
        max-width: 200px;
        height: 100px;
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