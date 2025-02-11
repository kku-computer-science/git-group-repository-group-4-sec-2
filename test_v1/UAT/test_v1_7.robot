*** Settings ***
Resource          ./resource_v1.robot
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

Test load cover img
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
   
    
Test input data
    # Input Text    id=title    
    Select From List By Label    id=category    1
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
Test load album
    # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
    Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
    Execute JavaScript    document.getElementById("image_album").style.display = "block";

    # รอให้ input file ปรากฏจริง
    Wait Until Element Is Visible    id=image_album    timeout=10s

    # ใช้ Send Keys แทนการใช้ Choose File
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg

Test save
    Sleep    2s

    # รอจนกว่าจะมีการบันทึก
    Click Button    xpath=//button[contains(text(),'Save')]


    # ตรวจสอบว่าแสดงป๊อปอัพที่มีข้อความ "โปรดกรอกฟิลด์นี้"

Test Tooltip Error Message 
    Wait Until Element Is Visible    xpath=//div[contains(text(),'please fill out this field')]    timeout=5s
Test อยู่หน้าเดิม
    # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
    Location Should Be    ${CREATE_NEWS_URL}  
   