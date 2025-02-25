*** Settings ***
Resource          D:/projectSoftEn/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***
${LAST_ROW}    xpath=//table[@id='news-table']//tbody/tr[last()]
${LAST_DELETE_BUTTON}    xpath=//table[@id='news-table']//tbody/tr[last()]//button[contains(@class,'btn-delete')]


* Keywords *

Create Highlight 

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/Users/User/Pictures/Screenshots/Screenshot_2025-02-18_215543.png
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่

    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Sleep    1s

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    C:/Users/User/Pictures/Screenshots/Screenshot_2025-02-18_215543.png
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();
    Wait Until Page Contains    สร้างข่าวสำเร็จ
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Delete Highlight

    # รอให้ตารางโหลดก่อน
    Wait Until Element Is Visible    ${LAST_ROW}    timeout=10s
    Wait Until Element Is Visible    ${LAST_DELETE_BUTTON}    timeout=5s

    # Log ตรวจสอบ XPath
    Log    ${LAST_DELETE_BUTTON}

    # เลื่อน Scroll ไปที่ปุ่มลบของแถวสุดท้าย
    Scroll Element Into View    ${LAST_DELETE_BUTTON}
    Sleep    1s   # รอให้หน้าโหลดและปุ่มแสดงผล

    # คลิกปุ่มลบ
    Click Button    ${LAST_DELETE_BUTTON}

    # รอให้ Popup ยืนยันแสดงขึ้นมา
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='คุณแน่ใจหรือไม่?']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, ลบเลย!']

    Sleep    5s

*** Test Cases ***

Test Add News To Full Highlights
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการเพิ่มข่าวเข้า Highlights เมื่อ Highlights เต็ม
    Go To Manage Highlights Page
    ${CREATE_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tbody/tr
    WHILE    ${CREATE_COUNT} < 6    
        Create Highlight
        ${CREATE_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tbody/tr
    END
    Sleep    2s
    Reload Page
    ${ROW_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
    Log To Console    จำนวนข่าวใน Highlights ก่อนเพิ่ม: ${ROW_COUNT}

    WHILE    ${ROW_COUNT} < 5
        # ดึง ID ของข่าวล่าสุดจากตาราง news-table
        ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[last()]//td[1])
        Log To Console    กำลังเพิ่มข่าวที่มี ID: ${NEWS_ID}

        # เลื่อน Scroll ไปที่ปุ่ม ADD
        Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
        Sleep    1s

        # รอให้ปุ่ม ADD พร้อมใช้งาน
        Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s

        # คลิกปุ่ม ADD
        Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]

        # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Show Highlights
        Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=10s
        # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
        Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s
        # รอให้ตารางอัปเดตก่อนตรวจสอบ
        Sleep    2s

        # นับจำนวนแถวใหม่
        ${ROW_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
        Log To Console    จำนวนข่าวใน Highlights หลังเพิ่ม: ${ROW_COUNT}

        # ตรวจสอบว่าข่าวหายไปจาก news-table
        ${NEWS_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tr
        Exit For Loop If    ${NEWS_COUNT} == 0
    END

    Reload Page
    ${ADD_BUTTON_STATE}    Get Element Attribute    xpath=(//table[@id='news-table']//tr[1]//button[contains(@class,'btn-add')])[1]    disabled
    Should Be Equal As Strings    ${ADD_BUTTON_STATE}    true
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    2s

    ${REMOVE_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
    WHILE    ${REMOVE_COUNT} > 0
        
        ${HIGHLIGHT_ID}    Get Element Attribute    xpath=(//table[@id='highlight-table']//tbody//tr[last()])    data-id
        Log    The Highlight ID is: ${HIGHLIGHT_ID}
        # เลื่อน Scroll ไปที่ปุ่ม REMOVE
        Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[@data-id='${HIGHLIGHT_ID}']//button[contains(@class,'btn-remove')])[1]
        Sleep    1s

        # รอให้ปุ่ม REMOVE พร้อมใช้งาน
        Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[@data-id='${HIGHLIGHT_ID}']//button[contains(@class,'btn-remove')])[1]    timeout=5s

        # คลิกปุ่ม REMOVE
        Click Button    xpath=(//table[@id='highlight-table']//tr[@data-id='${HIGHLIGHT_ID}']//button[contains(@class,'btn-remove')])[1]

        # รอให้ Highlight หายไปจากตาราง Show Highlights
        Wait Until Element Is Not Visible    xpath=//table[@id='highlight-table']//tr[@data-id='${HIGHLIGHT_ID}']    timeout=10s
        Sleep    2s
        
        # นับจำนวนแถวใหม่
        ${REMOVE_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
        Log To Console    จำนวนข่าวใน Highlights หลังเพิ่ม: ${REMOVE_COUNT}

    END


    ${DELETE_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tbody/tr
    WHILE    ${DELETE_COUNT} > 0    
        Delete Highlight
        ${DELETE_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tbody/tr
    END

    Close Browser