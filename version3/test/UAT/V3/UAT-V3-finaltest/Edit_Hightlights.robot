*** Settings ***
Resource          ../../resource_v3.robot

# Library           SeleniumLibrary
Library    Collections

*** Variables ***
${LAST_ROW}    xpath=//table[@id='news-table']//tbody/tr[last()]
${LAST_DELETE_BUTTON}    xpath=//table[@id='news-table']//tbody/tr[last()]//button[contains(@class,'btn-delete')]
${one_picture}    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_1.jpeg
${two_pictures}    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_2.jpeg
${TITLE_INPUT}    id=title
${DESCRIPTION_INPUT}    id=description
${LINK_INPUT}    id=link
${SAVE_BUTTON}  xpath=//button[contains(text(),'Update')]
${ADD_HIGHLIGHT_BTN}
${HOME_HIGHLIGHT_IMAGE_XPATH}    xpath=//div[@id='highlightNews']//img
${HIGHLIGHT_CARD}    xpath=//div[contains(@class,'carousel-item')][1]//a
${HIGHLIGHT_DETAIL_TITLE}    xpath=//h1[contains(@class,'highlight-title')]

${HEAD_IMAGE}    xpath=//div[@class='head-img']//img
${TITLE}    xpath=//h2
${TAGS}    xpath=//div[contains(@class,'d-flex') and contains(.,'แท็ก')]
${DESCRIPTION}    xpath=//pre
${REFERENCE_LINK}    xpath=//div[contains(text(),'แหล่งข้อมูลเพิ่มเติม')]//a
${IMAGE_ALBUM}    xpath=//div[contains(text(),'อัลบั้ม รูปภาพ')]
${AUTHOR}    xpath=//div[contains(@class,'justify-content-end')]//h6

${PROFILE_ICON}    xpath=//a[contains(@href,'/profile')]
# ${PROFILE_URL}    http://localhost/profile
${PROFILE_URL}    https://${HOST}/profile

${SUCCESS_MESSAGE}    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]

${TITLE_BEFORE_EDIT}   
${TAGS_BEFORE_EDIT}   
${DESCRIPTION_BEFORE_EDIT}    
${SOURCE_LINK_BEFORE_EDIT}   

*** Keywords ***

Refresh Page Once
    Reload Page
    Sleep    2s  # รอให้หน้าโหลดเสร็จ

Click Detail Before Edit
    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${HIGHLIGHTS_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-eye')]]


Edit Highlight
    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${HIGHLIGHTS_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล CoverImage
    Wait Until Element Is Visible    id=coverImageBox    timeout=10s
    Scroll Element Into View    id=coverImageBox
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_3.jpeg

    # แก้ไขข้อมูล Title
    Wait Until Element Is Visible    ${TITLE_INPUT}    timeout=5s
    Clear Element Text    ${TITLE_INPUT}
    Input Text    ${TITLE_INPUT}    หิวข้าว

    # แก้ไขข้อมูล Tag
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'select2-selection')]    timeout=5s
    Click Element    xpath=//span[contains(@class, 'select2-selection')]
    Wait Until Element Is Visible    xpath=//ul[contains(@class, 'select2-results__options')]    timeout=5s
    Click Element    xpath=//ul[contains(@class, 'select2-results__options')]//li[contains(text(), 'ผลงานวิจัยเด่นและรางวัล')]

    # แก้ไขข้อมูล Description
    Wait Until Element Is Visible    ${DESCRIPTION_INPUT}    timeout=10s
    Clear Element Text    ${DESCRIPTION_INPUT}
    Input Text    ${DESCRIPTION_INPUT}    ง่วงงงงงงงงงงงงงงงงงงงงงงงงงงง

    # แก้ไขข้อมูล Link
    Wait Until Element Is Visible    ${LINK_INPUT}    timeout=10s
    Clear Element Text    ${LINK_INPUT}
    Input Text    ${LINK_INPUT}   https://www.github.com/

    # แก้ไขข้อมูล ImageAlbum
    Wait Until Element Is Visible    id=imageAlbumBox    timeout=10s
    Scroll Element Into View    id=imageAlbumBox
    Execute JavaScript    document.getElementById('image_album').classList.remove('d-none');
    Choose File    id=image_album    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1.png

    # คลิกปุ่ม Update
    Wait Until Element Is Visible    ${SAVE_BUTTON}    timeout=10s
    Wait Until Element Is Enabled    ${SAVE_BUTTON}    timeout=5s
    ${save_button_element}=    Get WebElement    ${SAVE_BUTTON}
    Execute JavaScript    arguments[0].scrollIntoView({ behavior: "smooth", block: "center" });    ARGUMENTS    ${save_button_element}
    Sleep    1s
    Click Button    ${SAVE_BUTTON}

    # รอให้ระบบอัปเดตเสร็จและเช็คข้อความแจ้งเตือน
    Wait Until Page Contains    ยืนยันการอัปเดต    timeout=5s
    Click Button    xpath=//button[contains(text(),'ใช่, อัปเดตเลย!')]

    # รอให้กลับไปยังหน้า Manage Highlights
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=15s

    # ตรวจสอบว่ามีข้อความแจ้งเตือน "Highlight updated successfully!"
    Wait Until Element Is Visible    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]    timeout=5s
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    Refresh Page Once

    
Click Profile Icon to Manage Highlight
    Sleep    1s
    Wait Until Element Is Visible    ${PROFILE_ICON}    timeout=5s
    Click Element    ${PROFILE_ICON}
    Wait Until Location Is    ${PROFILE_URL}    timeout=5s

    Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=5s
    Page Should Contain    Manage Highlights

Click Home Icon
    Sleep    1s
    Wait Until Element Is Visible    xpath=//a[contains(@class, 'nav-link home-icon')]    timeout=10s
    Click Element    xpath=//a[contains(@class, 'nav-link home-icon')]
    Wait Until Location Is    ${URL}    ${DELAY}
    Sleep    1s

Click Highlight Card
    Sleep    1s
    Click Element    ${HIGHLIGHT_CARD}

Scroll Highlight Detail Page
    
    # ✅ ตรวจสอบว่ามีหัวข้อข่าว
    Wait Until Page Contains Element    ${TITLE}    timeout=5s
    ${title_text}=    Get Text    ${TITLE}
    Log    Title: ${title_text}

    # ✅ Scroll ดูแท็ก
    Execute JavaScript    window.scrollBy(0, 300)
    Wait Until Page Contains    แท็ก    timeout=10s
    Wait Until Element Is Visible    ${TAGS}    timeout=10s

    # ✅ Scroll ดูรายละเอียดเนื้อหา
    Execute JavaScript    window.scrollBy(0, 500)
    Wait Until Page Contains Element    ${DESCRIPTION}    timeout=5s

    # ✅ ถ้ามีลิงก์อ้างอิง ให้ตรวจสอบ
    ${has_reference}=    Run Keyword And Return Status    Element Should Be Visible    ${REFERENCE_LINK}
    Run Keyword If    ${has_reference}    Log    มีลิงก์อ้างอิง: ${REFERENCE_LINK}

    # ✅ ถ้ามีอัลบั้มรูป ให้ Scroll ไปดู
    ${has_album}=    Run Keyword And Return Status    Element Should Be Visible    ${IMAGE_ALBUM}
    Run Keyword If    ${has_album}    Execute JavaScript    window.scrollBy(0, 500)

    # ✅ Scroll ไปดูผู้เขียน
    Execute JavaScript    window.scrollBy(0, 300)
    Wait Until Page Contains Element    ${AUTHOR}    timeout=5s

    # ✅ Scroll ถึงสุดท้ายของหน้า
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    2s

    # ✅ Scroll กลับขึ้นไปด้านบนสุด
    Execute JavaScript    window.scrollTo(0, 0)
    Sleep    2s

Collect Detail Before Edit
    [Documentation]    เก็บรายละเอียดของข่าวก่อนแก้ไข และแสดง log ข้อมูลที่เก็บมา
    ${cover_image_src}    Get Element Attribute    xpath=//div[@class='head-img']/img    src
    ${title}    Get Text    xpath=//h2
    ${tags}    Get Text    xpath=//div[@class='d-flex flex-wrap']
    ${description}    Get Text    xpath=//pre
    ${source_link}    Get Element Attribute    xpath=//div[contains(@class, 'd-flex align-items-center')]/a    href

    Log    *** ข้อมูลก่อนแก้ไข ***
    Log    รูปภาพปก: ${cover_image_src}
    Log    หัวข้อข่าว: ${title}
    Log    แท็ก: ${tags}
    Log    รายละเอียดข่าว: ${description}
    Log    แหล่งข้อมูลเพิ่มเติม: ${source_link}
    # Run Keyword If    '${source_link}' != 'None'    Log    แหล่งข้อมูลเพิ่มเติม: ${source_link}
    Log    **************************

    Set Test Variable    ${COVER_IMAGE_BEFORE_EDIT}    ${cover_image_src}
    Set Test Variable    ${TITLE_BEFORE_EDIT}    ${title}
    Set Test Variable    ${TAGS_BEFORE_EDIT}    ${tags}
    Set Test Variable    ${DESCRIPTION_BEFORE_EDIT}    ${description}
    Set Test Variable    ${SOURCE_LINK_BEFORE_EDIT}    ${source_link}


Check Detail After Edit
    [Documentation]    ตรวจสอบว่ารายละเอียดของข่าวหลังแก้ไขถูกต้อง และแสดง log ข้อมูลที่เปลี่ยนแปลง
    ${cover_image_src_after}    Get Element Attribute    xpath=//div[@class='head-img']/img    src
    ${title_after}    Get Text    xpath=//h2
    ${tags_after}    Get Text    xpath=//div[@class='d-flex flex-wrap']
    ${description_after}    Get Text    xpath=//pre
    ${source_link_after}    Get Element Attribute    xpath=//div[contains(@class, 'd-flex align-items-center')]/a    href

    Log    *** ข้อมูลหลังแก้ไข ***
    Log    รูปภาพปก: ${cover_image_src_after}
    Log    หัวข้อข่าว: ${title_after}
    Log    แท็ก: ${tags_after}
    Log    รายละเอียดข่าว: ${description_after}
    Log    แหล่งข้อมูลเพิ่มเติม: ${source_link_after}
    Log    **************************

    Should Not Be Equal    ${COVER_IMAGE_BEFORE_EDIT}    ${cover_image_src_after}    รูปภาพปกไม่เปลี่ยนแปลงหลังแก้ไข
    Should Not Be Equal    ${TITLE_BEFORE_EDIT}    ${title_after}    หัวข้อข่าวไม่เปลี่ยนแปลงหลังแก้ไข
    Should Not Be Equal    ${TAGS_BEFORE_EDIT}    ${tags_after}    แท็กไม่เปลี่ยนแปลงหลังแก้ไข
    Should Not Be Equal    ${DESCRIPTION_BEFORE_EDIT}    ${description_after}    รายละเอียดข่าวไม่เปลี่ยนแปลงหลังแก้ไข
    Should Not Be Equal    ${SOURCE_LINK_BEFORE_EDIT}    ${source_link_after}    แหล่งข้อมูลเพิ่มเติมไม่เปลี่ยนแปลงหลังแก้ไข

    
*** Test Cases ***
Test Edit Highlight
    [Tags]    UAT-V3-edittest
    [Documentation]    ทดสอบการแก้ไขข่าวและดูข่าวสำเร็จ
        
    Go To Manage Highlights Page

    Click Detail Before Edit
    Collect Detail Before Edit
    Scroll Highlight Detail Page
    Click Profile Icon to Manage Highlight
    Edit Highlight
    Click Home Icon
    Click Highlight Card
    Scroll Highlight Detail Page
    Check Detail After Edit

    Close Browser