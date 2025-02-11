*** Settings ***
Resource          ./resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***

# Test Scenario ID:	UAT-V1-01
Test Open Home Page
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการเปิดเว็บไซต์
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Close Browser

Test Go To Login Page
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการเข้าหน้า Login
    Go To Login Page
    Close Browser
    
Test Login Role Admin Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Admin สำเร็จ
    Go To Login Page
    Login Admin
    Verify Admin Dashboard
    Close Browser

Test Login Role Staff Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    Close Browser

Test Login Role Researcher Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Researcher สำเร็จ
    Go To Login Page
    Login Researcher
    Verify Researcher Dashboard
    Close Browser

# # Test Scenario ID:	UAT-V1-02














# # Test Scenario ID:	UAT-V1-03
Test Go To Manage Highlights Page
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ และเข้าหน้า Manage Highlights
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    # 7. คลิกปุ่ม Manage Highlights
    Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
    Page Should Contain    Manage Highlights
    Close Browser

Test Create News Unsuccess Empty Cover Image
    # ❌ Fail
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่รูปภาพ Cover Image
    Go To Manage Highlights Page
    Scroll Element Into View    xpath=//a[contains(text(),'+ Create')]
    Wait Until Element Is Visible    xpath=//a[contains(text(),'+ Create')]    timeout=5s
    Click Element    xpath=//a[contains(text(),'+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Scroll Element Into View    id=title
    Wait Until Element Is Visible    id=title    timeout=5s
    Wait Until Element Is Enabled    id=title    timeout=5s
    Input Text    id=title    ${TITLE}
    Scroll Element Into View    id=category
    Wait Until Element Is Visible    id=category    timeout=5s
    Wait Until Element Is Enabled    id=category    timeout=5s
    Click Element    id=category
    Select From List By Value    id=category    1
    Scroll Element Into View    id=description
    Wait Until Element Is Visible    id=description    timeout=5s
    Wait Until Element Is Enabled    id=description    timeout=5s
    Input Text    id=description    ${DESCRIPTION}
    Scroll Element Into View    id=imageAlbumBox
    Wait Until Element Is Visible    id=imageAlbumBox    timeout=5s
    Wait Until Element Is Visible    id=image_album    timeout=5s
    Execute JavaScript    var fileInput = document.getElementById('image_album'); var dt = new DataTransfer(); var file = new File([''], '${CURDIR}/../Test-Data/kirito.jpg', {type: 'image/jpeg'}); dt.items.add(file); fileInput.files = dt.files;
    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser


Test Create News Unsuccess Empty Title:
    # ❌ Fail
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่ Title
    Go To Manage Highlights Page
    Scroll Element Into View    xpath=//a[contains(text(),'+ Create')]
    Wait Until Element Is Visible    xpath=//a[contains(text(),'+ Create')]    timeout=5s
    Click Element    xpath=//a[contains(text(),'+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    # อัปโหลดรูปภาพ Cover Image
    Scroll Element Into View    id=coverImageBox
    Wait Until Element Is Visible    id=coverImageBox    timeout=5s
    Wait Until Element Is Visible    id=cover_image    timeout=5s
    # Choose File    xpath=//input[@id='cover_image']    ../Test-Data/kirito.jpg
    Choose File    id=cover_image    ../Test-Data/kirito.jpg
    # ไม่ใส่ Title
    Sleep    2s
    Scroll Element Into View    id=category
    Wait Until Element Is Visible    id=category    timeout=5s
    Wait Until Element Is Enabled    id=category    timeout=5s
    Click Element    id=category
    Select From List By Value    id=category    ""
    Scroll Element Into View    id=description
    Wait Until Element Is Visible    id=description    timeout=5s
    Wait Until Element Is Enabled    id=description    timeout=5s
    Input Text    id=description    "เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ"
    Scroll Element Into View    id=imageAlbumBox
    Wait Until Element Is Visible    id=imageAlbumBox    timeout=5s
    Wait Until Element Is Visible    id=image_album    timeout=5s
    Choose File    id=image_album    ${CURDIR}/../Test-Data/kirito.jpg
    # กดปุ่ม Save
    Scroll Element Into View    xpath=//button[contains(@class,'btn-dark') and text()='Save']
    Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark') and text()='Save']    timeout=5s
    Click Button    xpath=//button[contains(@class,'btn-dark') and text()='Save']
    # ตรวจสอบว่ามี Tooltip แจ้งเตือนให้กรอก Title
    Wait Until Element Is Visible    xpath=//input[@id='title' and @required]    timeout=5s
    Element Should Contain    xpath=//input[@id='title']    โปรดกรอกฟิลด์นี้
    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser


Test Create News Unsuccess Empty Category:
    # ❌ Fail
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่เลือก Category
    Go To Manage Highlights Page
    Scroll Element Into View    xpath=//a[contains(text(),'+ Create')]
    Wait Until Element Is Visible    xpath=//a[contains(text(),'+ Create')]    timeout=5s
    Click Element    xpath=//a[contains(text(),'+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    # อัปโหลดรูปภาพ Cover Image
    Scroll Element Into View    id=coverImageBox
    Wait Until Element Is Visible    id=coverImageBox    timeout=5s
    Wait Until Element Is Visible    id=cover_image    timeout=5s
    Choose File    id=cover_image    ${CURDIR}/../Test-Data/kirito.jpg
    # กรอกข้อมูล Title
    Scroll Element Into View    id=title
    Wait Until Element Is Visible    id=title    timeout=5s
    Wait Until Element Is Enabled    id=title    timeout=5s
    Input Text    id=title    "โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่"
    # ไม่เลือก Category
    Scroll Element Into View    id=category
    Wait Until Element Is Visible    id=category    timeout=5s
    Wait Until Element Is Enabled    id=category    timeout=5s
    Click Element    id=category
    Select From List By Value    id=category    ""
    # กรอกข้อมูล Description
    Scroll Element Into View    id=description
    Wait Until Element Is Visible    id=description    timeout=5s
    Wait Until Element Is Enabled    id=description    timeout=5s
    Input Text    id=description    "เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ"
    # อัปโหลดรูปภาพ Image Album
    Scroll Element Into View    id=imageAlbumBox
    Wait Until Element Is Visible    id=imageAlbumBox    timeout=5s
    Wait Until Element Is Visible    id=image_album    timeout=5s
    Choose File    id=image_album    ${CURDIR}/../Test-Data/kirito.jpg
    # กดปุ่ม Save
    Scroll Element Into View    xpath=//button[contains(@class,'btn-dark') and text()='Save']
    Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark') and text()='Save']    timeout=5s
    Click Button    xpath=//button[contains(@class,'btn-dark') and text()='Save']
    # ตรวจสอบว่ามี popup แจ้งเตือนให้เลือกหมวดหมู่
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='กรุณาเลือกหมวดหมู่!']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ตกลง']
    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser


Test Edit News:
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการแก้ไขข่าว
    Go To Manage Highlights Page
    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    # แก้ไขข้อมูล Title
    Scroll Element Into View    id=title
    Wait Until Element Is Visible    id=title    timeout=5s
    Wait Until Element Is Enabled    id=title    timeout=5s
    Input Text    id=title    ${TITLE}
    # กดปุ่ม Update
    # กดปุ่ม Update
    Scroll Element Into View    xpath=//button[contains(@class,'btn-dark') and text()='Update']
    Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark') and text()='Update']    timeout=5s
    Click Button    xpath=//button[contains(@class,'btn-dark') and text()='Update']
    # กดปุ่ม "ใช่, อัปเดตเลย!"
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']
    # รอให้กลับไปยังหน้า Manage Highlights
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s
    # ตรวจสอบว่ามีข้อความแจ้งเตือน "Highlight updated successfully!"
    Wait Until Element Is Visible    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]    timeout=5s


Test Delete News
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการลบข่าว
    Go To Manage Highlights Page
    # ค้นหา ID ของ News ที่ต้องการลบ (เลือกอันแรกสุด)
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    # เลื่อน Scroll ไปที่ปุ่มลบของ News อันแรก
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]    timeout=5s
    Click Button    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
    # รอให้ Popup แจ้งเตือนปรากฏ
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='คุณแน่ใจหรือไม่?']    timeout=5s
    # กดปุ่ม "ใช่, ลบเลย!"
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, ลบเลย!']
    # รอให้หน้าเปลี่ยนกลับไปยัง Manage Highlights
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s
    # รอให้แถวที่มี ID ที่ถูกลบหายไปจริงๆ
    Wait Until Element Is Not Visible    xpath=//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]    timeout=10s


Test Remove News Form Highlights
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการนำข่าวออกจาก Highlights
    Go To Manage Highlights Page
    # ค้นหา ID ของ News ที่ต้องการนำออกจาก Highlights (เลือกอันแรกสุด)
    ${HIGHLIGHT_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
    # เลื่อน Scroll ไปที่ปุ่ม REMOVE ของ Highlight อันแรก
    Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]    timeout=5s
    Click Button    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
    # รอให้ Popup แจ้งเตือนปรากฏ
    Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'นำออกจาก Highlights แล้ว!')]    timeout=5s
    # รอให้ Highlight หายไปจากตาราง Highlights
    Wait Until Element Is Not Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${HIGHLIGHT_ID}']]    timeout=10s
    # รอให้ตารางอัปเดตก่อนตรวจสอบ
    Sleep    2s  
    # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง News อย่างถูกต้อง
    Wait Until Element Is Visible    xpath=//table[@id='news-table']//tr/td[1][normalize-space(text())='${HIGHLIGHT_ID}']    timeout=10s


Test Add News To Full Highlights
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการเพิ่มข่าวเข้า Highlights เมื่อ Highlights เต็ม
    Go To Manage Highlights Page
    # ตรวจสอบว่าปุ่ม "ADD" ถูกปิดใช้งาน (disabled) เมื่อ Highlights เต็ม
    ${ADD_BUTTON_STATE}    Get Element Attribute    xpath=(//table[@id='news-table']//tr[1]//button[contains(@class,'btn-add')])[1]    disabled
    Should Be Equal As Strings    ${ADD_BUTTON_STATE}    true
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}