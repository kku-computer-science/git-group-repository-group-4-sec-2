*** Settings ***
Resource          ./resource_v1.robot
Library           SeleniumLibrary


*** Variables ***

*** Test Cases ***
# Test Scenario ID:	UAT-V1-03
Test Create News Unsuccess Empty Category
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}
     Click Element    id=coverImageBox
     Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    # Select From List By Label    id=category    1
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
    Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
    Execute JavaScript    document.getElementById("image_album").style.display = "block";
    # รอให้ input file ปรากฏจริง
    Wait Until Element Is Visible    id=image_album    timeout=10s
    # ใช้ Send Keys แทนการใช้ Choose File
    Input Text    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Sleep    2s
# เลื่อนไปยังปุ่ม Save
    Scroll Element Into View    xpath=//button[contains(text(),'Save')]
    # รอจนกว่าปุ่ม Save จะปรากฏ
    Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
    # รอจนกว่าปุ่ม Save จะพร้อมคลิก
    Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
    # รอจนกว่าจะมีการบันทึก
    Click Button    xpath=//button[contains(text(),'Save')]
    # ตรวจสอบว่าแสดงป๊อปอัพที่มีข้อความ "โปรดกรอกฟิลด์นี้"
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']    timeout=5s
# ตรวจสอบว่าแสดงข้อความ "กรุณาเลือกหมวดหมู่!"
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาเลือกหมวดหมู่!
# ตรวจสอบข้อความในส่วนของรายละเอียด
    Element Should Contain    xpath=//div[@class='swal2-html-container']    คุณต้องเลือกหมวดหมู่ก่อนส่งแบบฟอร์ม
# รอจนกว่าป๊อปอัพจะปรากฏ
    Wait Until Element Is Visible    xpath=//button[@class='swal2-confirm swal2-styled swal2-default-outline']    timeout=5s
# คลิกปุ่ม "ตกลง" ในป๊อปอัพ
    Click Button    xpath=//button[@class='swal2-confirm swal2-styled swal2-default-outline']
    # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
    Location Should Be    ${CREATE_NEWS_URL}  