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

#     # ค้นหาข้อมูล Highlights ที่ต้องการเพิ่มไปยัง Show Highlights (เลือกอันล่าสุดที่เพิ่มเข้ามา)
#     ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[last()]//td[1])
#     # เลื่อน Scroll ไปที่ปุ่ม ADD ของ Highlights อันล่าสุด
#     Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
#     # รอจนกว่าปุ่ม ADD จะมองเห็นและคลิก
#     Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Show Highlights
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=10s
#     # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
#     Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s
#     # รอให้ตารางอัปเดตก่อนตรวจสอบ
#     Sleep    2s
#     # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง highlight-table
#     ${highlight_table_row}=    Get Text    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${NEWS_ID}')]]
#     Should Contain    ${highlight_table_row}    ${NEWS_ID}
#     Should Contain    ${highlight_table_row}    REMOVE  # ตรวจสอบว่าแถวมีปุ่ม REMOVE
#     # ตรวจสอบว่า ${NEWS_ID} ไม่มีอยู่ในตาราง news-table อีกแล้ว
#     ${news_table_row}=    Run Keyword And Return Status    Get Text    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]
#     Should Not Be Equal    ${news_table_row}    ${NEWS_ID}    # ตรวจสอบว่า ${NEWS_ID} ไม่ปรากฏในตาราง news-table
   
#     # ลบ highlight
#     # ค้นหา ID ของ Highlights ที่ต้องการนำออกจาก Show Highlights (เลือกอันล่าสุดที่เพิ่มเข้ามา)
#     ${HIGHLIGHT_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr[last()]//td[1])
#     # เลื่อน Scroll ไปที่ปุ่ม REMOVE ของ Highlight อันล่าสุด
#     Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
#     Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏ
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'นำออกจาก Highlights แล้ว!')]    timeout=5s
#     # รอให้ Highlight หายไปจากตาราง Show Highlights
#     Wait Until Element Is Not Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${HIGHLIGHT_ID}']]    timeout=10s
#     # รอให้ตารางอัปเดตก่อนตรวจสอบ
#     Sleep    2s

#     #ลบไฮไลต์ที่สร้างขึ้นมาล่าสุด
#     # ค้นหา ID ของ Highlights ที่ต้องการลบ (เลือกอันล่าสุดที่เพิ่มเข้ามา)
#     ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[last()]//td[1])
#     # เลื่อน Scroll ไปที่ปุ่มลบของ Highlights อันล่าสุด
#     Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
#     Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏ
#     Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='คุณแน่ใจหรือไม่?']    timeout=5s
#     Sleep    2s
#     # กดปุ่ม "ใช่, ลบเลย!"
#     Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, ลบเลย!']
#     # รอให้หน้าเปลี่ยนกลับไปยัง Manage Highlights
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s
#     # รอให้แถวที่มี ID ที่ถูกลบหายไปจริงๆ
#     Wait Until Element Is Not Visible    xpath=//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]    timeout=10s
#     Sleep    2s

#     Close Browser