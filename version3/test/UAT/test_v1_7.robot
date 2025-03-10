*** Settings ***
Resource          C:\work_2025\git-group-repository-group-4-sec-2\version3\test\UAT\resource_v3.robot
Library           SeleniumLibrary


*** Variables ***

*** Test Cases ***
# Test Scenario ID:	UAT-V1-03
Test Create News Unsuccess Empty Title
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    # Input Text    id=title    ""
    Sleep    2s
    Scroll Element Into View    id=category
    # Wait Until Element Is Visible    id=category    timeout=5s
    # Wait Until Element Is Enabled    id=category    timeout=5s
    # Click Element    id=category
    Select From List By Value    id=category    1
    Scroll Element Into View    id=description
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
    Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
    Execute JavaScript    document.getElementById("image_album").style.display = "block";
    # รอให้ input file ปรากฏจริง
    Wait Until Element Is Visible    id=image_album    timeout=10s
    # ใช้ Send Keys แทนการใช้ Choose File
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Sleep    2s
    # เลื่อนไปยังปุ่ม Save
    Scroll Element Into View    xpath=//button[contains(text(),'Save')]
    # รอจนกว่าปุ่ม Save จะปรากฏ
    Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
    # รอจนกว่าปุ่ม Save จะพร้อมคลิก
    Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
    # รอจนกว่าจะมีการบันทึก
    Click Button    xpath=//button[contains(text(),'Save')]
    Click Button    xpath=//button[contains(text(),'Save')]
    Sleep    1s  # รอให้แจ้งเตือนแสดง
    Run Keyword And Continue On Failure    Element Should Be Visible    xpath=//input[@id='title'][@required]
    # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
    Location Should Be    ${CREATE_NEWS_URL}  
    Close Browser
   