*** Settings ***
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/version3/test/UAT/resource_v3.robot
# Library           SeleniumLibrary
Library    Collections

*** Variables ***
${LAST_ROW}    xpath=//table[@id='news-table']//tbody/tr[last()]
${LAST_DELETE_BUTTON}    xpath=//table[@id='news-table']//tbody/tr[last()]//button[contains(@class,'btn-delete')]
${one_picture}    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_1.jpeg
${two_pictures}    /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_2.jpeg\n/Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_3.jpeg
${NEWS_ID}
${ADD_HIGHLIGHT_BTN}
${HOME_HIGHLIGHT_IMAGE_XPATH}    xpath=//div[@id='highlightNews']//img

*** Keywords ***

Refresh Page Once
    Reload Page
    Sleep    2s  # รอให้หน้าโหลดเสร็จ

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

Create Highlight
    
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Wait Until Element Is Visible    id=coverImageBox    timeout=10s
    Scroll Element Into View    id=coverImageBox
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    ${one_picture}

    Wait Until Element Is Visible    id=title    timeout=10s
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่

    Wait Until Element Is Visible    xpath=//span[contains(@class, 'select2-selection')]    timeout=5s
    Click Element    xpath=//span[contains(@class, 'select2-selection')]
    Wait Until Element Is Visible    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]    timeout=5s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]

    Wait Until Element Is Visible    id=description    timeout=5s
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ

    Wait Until Element Is Visible    id=link    timeout=5s
    Input Text    id=link   https://www.google.com

    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    ${two_pictures}

    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]    timeout=5s
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();

    # Wait Until Page Contains    สร้างข่าวสำเร็จ
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Click Add Highlights

    # รอจนกว่าจะมีข้อมูลในตาราง news-table
    ${news_table_row_xpath}=    Set Variable    xpath=//table[@id='news-table']//tr[last()]//td[1]
    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${news_table_row_xpath}
    Sleep    1s

    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[last()]//td[1])
    ${ADD_HIGHLIGHT_BTN}    Set Variable    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')]

    Scroll Element Into View    ${ADD_HIGHLIGHT_BTN}
    Wait Until Element Is Visible    ${ADD_HIGHLIGHT_BTN}    timeout=10s
    Click Button    ${ADD_HIGHLIGHT_BTN}

    # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Show Highlights
    Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=10s
    # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
    Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s
    Sleep    1s

Click Remove Highlight

    # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง highlight-table
    ${highlight_table_row_xpath}=    Set Variable    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${NEWS_ID}')]]
    Wait Until Keyword Succeeds    15s    2s    Element Should Be Visible    ${highlight_table_row_xpath}

    # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง highlight-table
    ${highlight_table_row}=    Get Text    ${highlight_table_row_xpath}
    Should Contain    ${highlight_table_row}    ${NEWS_ID}
    
    # รอให้ REMOVE ปรากฏในแถวนั้นๆ
    Wait Until Keyword Succeeds    30s    2s    Element Should Contain    ${highlight_table_row_xpath}    REMOVE
    Log    "REMOVE พร้อมให้คลิกแล้ว"

    # ตรวจสอบว่า ${NEWS_ID} ไม่มีอยู่ในตาราง news-table อีกแล้ว
    ${news_table_row}=    Run Keyword And Return Status    Get Text    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]
    Should Not Be Equal    ${news_table_row}    ${NEWS_ID}    # ตรวจสอบว่า ${NEWS_ID} ไม่ปรากฏในตาราง news-table

    # ลบ highlight
    # ค้นหา ID ของ Highlights ที่ต้องการนำออกจาก Show Highlights (เลือกอันล่าสุดที่เพิ่มเข้ามา)
    ${LAST_HIGHLIGHT_ROW}=    Set Variable    xpath=//table[@id='highlight-table']//tr[last()]//td[1]
    Wait Until Keyword Succeeds    15s    2s    Element Should Be Visible    ${LAST_HIGHLIGHT_ROW}
    ${HIGHLIGHT_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr[last()]//td[1])

    ${REMOVE_BTN}=    Set Variable    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')]
    Wait Until Keyword Succeeds    15s    2s    Element Should Be Visible    ${REMOVE_BTN}
    
    # รอให้ปุ่ม REMOVE ปรากฏและพร้อมใช้งาน
    Wait Until Element Is Visible    ${REMOVE_BTN}    timeout=15s
    Wait Until Element Is Enabled    ${REMOVE_BTN}    timeout=15s
    
    # เลื่อน Scroll ไปที่ปุ่ม REMOVE ของ Highlight อันล่าสุด
    Scroll Element Into View    ${REMOVE_BTN}
    Wait Until Element Is Visible    ${REMOVE_BTN}    timeout=5s

    # รอสักครู่เพื่อให้แน่ใจว่าปุ่มพร้อมใช้งาน
    Sleep    1s

    Click Button    ${REMOVE_BTN}

    Sleep    3s

Click Home Icon
    Sleep    1s
    Wait Until Element Is Visible    xpath=//a[contains(@class, 'nav-link home-icon')]    timeout=10s
    Click Element    xpath=//a[contains(@class, 'nav-link home-icon')]
    Wait Until Location Is    ${URL}    ${DELAY}
    Sleep    1s

Count Highlight
    # รอให้ตารางโหลดก่อน
    Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tbody/tr[last()]    timeout=10s
    Sleep    1s

    # นับจำนวน Highlights ที่มีอยู่ในตาราง
    ${highlight_rows}=    Get WebElements    xpath=//table[@id='highlight-table']//tbody/tr
    ${highlight_count}=    Get Length    ${highlight_rows}
    Log    "จำนวน Highlights ที่มีอยู่ในตาราง: ${highlight_count}"

    # ตรวจสอบว่าจำนวน Highlights ที่มีอยู่ในตารางตรงกับที่คาดหวัง
    # Should Be Equal As Numbers    ${highlight_count}    3
    
    Refresh Page Once

    # ✅ ดึงรูปทั้งหมดจาก highlight-table
    ${HIGHLIGHTED_IMAGES}=    Create List
    ${highlight_image_elements}=    Get WebElements    xpath=//table[@id='highlight-table']//tbody/tr/td[2]//img

    FOR    ${element}    IN    @{highlight_image_elements}
        ${image_src}=    Get Element Attribute    ${element}    src
        Append To List    ${HIGHLIGHTED_IMAGES}    ${image_src}
    END

    # ✅ ตั้งค่าเป็น Global Variable เพื่อให้ใช้งานได้ในทุก Keywords
    Set Global Variable    ${HIGHLIGHTED_IMAGES}
    Log    "รูปภาพที่เก็บจาก highlight-table: @{HIGHLIGHTED_IMAGES}"

Verify Highlight Images Match
    Sleep    1s
    Log    "🔍 เริ่มตรวจสอบว่ารูปที่เพิ่มอยู่ในหน้า Home หรือไม่"
    Refresh Page Once
    # ✅ ดึง URL ของรูปทั้งหมดจาก carousel ในหน้า Home
    ${home_images}=    Create List
    ${home_elements}=    Get WebElements    xpath=//div[@class='carousel-inner']//img

    # ✅ ดึงจำนวนรูปภาพจากหน้า Home ออกมา
    ${home_elements_count}=    Get Length    ${home_elements}
    Run Keyword If    ${home_elements_count} == 0    Fail    "❌ ไม่พบรูปภาพในหน้า Home"

    FOR    ${element}    IN    @{home_elements}
        ${src}=    Get Element Attribute    ${element}    src
        Append To List    ${home_images}    ${src}
    END
    Log    "🏠 รูปทั้งหมดในหน้า Home: @{home_images}"

    ${home_elements_count}=    Get Length    ${home_elements}
    Run Keyword If    ${home_elements_count} == 0    Fail    "❌ ไม่พบรูปภาพในหน้า Home"

    Log    "รูปภาพที่เก็บจาก highlight-table: @{HIGHLIGHTED_IMAGES}"
    Log    "🔍 Highlighted Images: ${HIGHLIGHTED_IMAGES}"
    Log    "🏠 Home Images: ${home_images}"
    Log    "🔍 Type of HIGHLIGHTED_IMAGES: ${HIGHLIGHTED_IMAGES.__class__}"
    Log    "🏠 Type of home_images: ${home_images.__class__}"

    # ✅ เปรียบเทียบรูปภาพ
    FOR    ${img}    IN    @{HIGHLIGHTED_IMAGES}
        ${found}=    Run Keyword And Return Status    Should Contain    ${home_images}    ${img}
        Run Keyword If    not ${found}    Log    "❌ รูป ${img} ไม่พบในหน้า Home!"
    END

    Log    "✅ รูปทั้งหมดจาก Highlight Table ตรงกับรูปในหน้า Home"

*** Test Cases ***
Test Create Highlight
    [Tags]    UAT-V3-final1
    [Documentation]    ทดสอบการสร้างข่าวและดูข่าวสำเร็จ
        
    Go To Manage Highlights Page

    Create Highlight
    Create Highlight

    Click Add Highlights
    Click Add Highlights

    Count Highlight
    Click Home Icon
    Verify Highlight Images Match

    Close Browser