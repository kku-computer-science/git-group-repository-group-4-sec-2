*** Settings ***
Resource          D:/projectSoftEn/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***

Test Add News To Full Highlights
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการเพิ่มข่าวเข้า Highlights เมื่อ Highlights เต็ม
    Go To Manage Highlights Page
    ${ROW_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
    Log To Console    จำนวนข่าวใน Highlights: ${ROW_COUNT}

    WHILE    ${ROW_COUNT} < 5
        ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[1]//td[1])[1]
        Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
    
        # รอให้ Popup ปิดก่อนคลิกปุ่ม ADD
        Wait Until Element Is Not Visible    xpath=//div[contains(@class,'swal2-container')]    timeout=5s
    
        # กดปุ่ม ESC เพื่อปิด Popup ถ้ายังไม่ปิด
        Press Keys    NONE    ESC
        Sleep    1s
    
        # รอให้ปุ่มพร้อมใช้งาน
        Wait Until Element Is Enabled    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s
        Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]

        # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
        Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s

        # นับจำนวนใหม่
        ${ROW_COUNT}    Get Element Count    xpath=//table[@id='highlight-table']//tbody/tr
        Log To Console    จำนวนข่าวใน Highlights หลังเพิ่ม: ${ROW_COUNT}

        ${NEWS_COUNT}    Get Element Count    xpath=//table[@id='news-table']//tr
        Exit For Loop If    ${NEWS_COUNT} == 0

    END
  
    ${ADD_BUTTON_STATE}    Get Element Attribute    xpath=(//table[@id='news-table']//tr[1]//button[contains(@class,'btn-add')])[1]    disabled   
    Should Be Equal As Strings    ${ADD_BUTTON_STATE}    true
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    2s
    
    Close Browser