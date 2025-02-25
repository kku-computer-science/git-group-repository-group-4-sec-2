*** Settings ***
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***
${LAST_DELETE_BUTTON}    xpath=//tbody/tr[last()]//button[contains(@class,'btn-delete')]

*** Keywords ***

Delete Highlight

    # รอให้ตารางโหลดก่อน
    Wait Until Element Is Visible    ${LAST_DELETE_BUTTON}    timeout=10s

    # Log ตรวจสอบว่าพบปุ่มลบจริงหรือไม่
    Log    ${LAST_DELETE_BUTTON}

    # เลื่อน Scroll ไปที่ปุ่มลบของแถวสุดท้าย
    Scroll Element Into View    ${LAST_DELETE_BUTTON}
    Wait Until Element Is Visible    ${LAST_DELETE_BUTTON}    timeout=5s
    Click Button    ${LAST_DELETE_BUTTON}

    # รอให้ Popup แจ้งเตือนขึ้นมา
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='คุณแน่ใจหรือไม่?']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, ลบเลย!']

*** Test Cases ***

Test Go To Manage Highlights Page
    Go To Manage Highlights Page
    Close Browser

Test Create News Success
    # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่สำเร็จ
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่

    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Sleep    1s

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg\n/Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_3.jpeg
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();
    Wait Until Page Contains    สร้างข่าวสำเร็จ
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    Delete Highlight

    Close Browser

