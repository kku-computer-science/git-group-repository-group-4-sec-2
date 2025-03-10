*** Settings ***
Resource          C:\work_2025\git-group-repository-group-4-sec-2\version3\test\UAT\resource_v3.robot
Library           SeleniumLibrary


*** Variables ***

*** Test Cases ***
# Test Scenario ID:	UAT-V1-03
Test Create News Success
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Select From List By Value    id=category    1
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Scroll Element Into View    id=imageAlbumBox
    Wait Until Element Is Visible    id=imageAlbumBox    timeout=5s
    # Wait Until Element Is Visible    id=image_album    timeout=5s
    # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
    Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
    Execute JavaScript    document.getElementById("image_album").style.display = "block";
    # ใช้ Send Keys แทนการใช้ Choose File
    Input Text    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    # รอให้ไฟล์โหลดเสร็จ
    Sleep    2s
    # ซ่อน dialog ของ choose file
    Execute JavaScript    document.querySelector('input[type="file"]').blur()
    # เลื่อนหน้าไปยังปุ่ม Save
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
 # เลื่อนไปยังปุ่ม Save
    Scroll Element Into View    xpath=//button[contains(text(),'Save')]
    # รอจนกว่าปุ่ม Save จะปรากฏ
    Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
    # รอจนกว่าปุ่ม Save จะพร้อมคลิก
    Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
    # คลิกปุ่ม Save
    Click Button    xpath=//button[contains(text(),'Save')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}

# *** Settings ***
# Resource          ./resource_v1.robot
# Library           SeleniumLibrary


# *** Variables ***
# ${COVER_IMAGE_PATH}    ${EXECDIR}\\test_v1\\Test-Data\\1.png
# ${ALBUM_IMAGE_PATH}    ${EXECDIR}\\test_v1\\Test-Data\\1_1.png
# *** Test Cases ***
# # Test Scenario ID:	UAT-V1-03
# Test Login Role Staff success
#     [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
#     Go To Login Page
#     Input Text    id=username    ${STAFF_USERNAME}
#     Input Text    id=password    ${STAFF_PASSWORD}
#     Click Button    xpath=//button[contains(text(),'Log In')]
#     Wait Until Location Is    ${DASHBOARD_URL}    

# Test DASHBOARD To MANAGE HIGHLIGHTS
#     Location Should Be    ${DASHBOARD_URL}
#     Click Element    xpath=//span[contains(text(),'Manage Highlights')]
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}   

# Test Click +Create MANAGE HIGHLIGHTS
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Wait Until Location Is    ${HIGHLIGHTS_CREATE_URL}    ${DELAY}

# Test Create News Success
#     Location Should Be    ${HIGHLIGHTS_CREATE_URL}

#     # คลิกที่ coverImageBox
#     Click Element    id=coverImageBox
    
#     # ใช้ SeleniumLibrary เพื่อเลือกไฟล์จาก input file
#     Choose File    id=cover_image    ${COVER_IMAGE_PATH}
    
#     # รอจนกว่าภาพตัวอย่างจะปรากฏ (ตรวจสอบว่าไฟล์ถูกเลือก)
#     Wait Until Element Is Visible    id=coverPreviewImg    ${DELAY}

#     # กรอกข้อมูลฟอร์ม
#     Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
#     Select From List By Value    id=category    1
#     Input Text    id=detail    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    
#     # คลิกที่ imageAlbumBox
#     Click Element    id=imageAlbumBox
    
#     # ใช้ SeleniumLibrary เพื่อเลือกไฟล์จาก input file
#     Choose File    ${ALBUM_IMAGE_PATH}
    
#     # รอจนกว่าภาพในอัลบัมจะปรากฏ
#     Wait Until Element Is Visible    id=albumPreviewImg    ${DELAY}
    
#     # กดบันทึก
#     Click Button    xpath=//button[contains(text(),'Save')]
    
#     # รอจนกว่าจะถึงหน้าการจัดการ
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}