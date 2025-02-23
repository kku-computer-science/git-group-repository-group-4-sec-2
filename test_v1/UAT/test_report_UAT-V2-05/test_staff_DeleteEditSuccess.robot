*** Settings ***
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
# Test Scenario ID:	UAT-V1-03

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
    Close Browser

Test Edit News:
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการแก้ไขข่าว
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]

    # แก้ไขข้อมูล Title
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
    Input Text    id=title    การเปลี่ยนแปลง
    Select From List By Label    id=category     งานประชุมและสัมมนาวิชาการ
    Input Text    id=description    กำหนดการเปลี่ยนแปลง

    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\n/Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_3.jpeg

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
    Close Browser