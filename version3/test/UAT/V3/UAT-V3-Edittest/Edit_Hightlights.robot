*** Settings ***
Resource          ../../resource_v3.robot

# Library           SeleniumLibrary
Library    Collections

*** Variables ***
${LAST_ROW}    xpath=//table[@id='news-table']//tbody/tr[last()]
${LAST_DELETE_BUTTON}    xpath=//table[@id='news-table']//tbody/tr[last()]//button[contains(@class,'btn-delete')]
${one_picture}    C:/work_2025/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_1.jpeg
${two_pictures}    C:/work_2025/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_2.jpeg
${NEWS_ID}
${NEW_TITLE}    โครงการtttttttttttttttt
${ADD_HIGHLIGHT_BTN}
${HOME_HIGHLIGHT_IMAGE_XPATH}    xpath=//div[@id='highlightNews']//img

*** Keywords ***

Refresh Page Once
    Reload Page
    Sleep    2s  # รอให้หน้าโหลดเสร็จ

Edit Title Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${HIGHLIGHTS_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHTS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล Title
    Wait Until Element Is Visible    id=title    timeout=10s
    Input Text    id=title    หิวข้าว

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
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Edit CoverImage Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล CoverImage
    Wait Until Element Is Visible    id=coverImageBox    timeout=10s
    Scroll Element Into View    id=coverImageBox
    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1_3.jpeg
    
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
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Edit Tag Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล Tag
    Wait Until Element Is Visible    xpath=//span[contains(@class, 'select2-selection')]    timeout=5s
    Click Element    xpath=//span[contains(@class, 'select2-selection')]
    Wait Until Element Is Visible    xpath=//li[contains(text(), 'ผลงานวิจัยเด่นและรางวัล')]    timeout=5s
    Click Element    xpath=//li[contains(text(), 'ผลงานวิจัยเด่นและรางวัล')]

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
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    
Edit Description Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล Description
    Input Text    id=description    ง่วงนอน

    # กดปุ่ม Update
    Scroll Element Into View    xpath=//button[contains(@class,'btn-dark')]
    Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark')]    timeout=5s
    Click Button    xpath=//button[contains(@class,'btn-dark')]

    # กดปุ่ม "ใช่, อัปเดตเลย!"
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']

    # รอให้กลับไปยังหน้า Manage Highlights
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s

    # ตรวจสอบว่ามีข้อความแจ้งเตือน "Highlight updated successfully!"
    Wait Until Element Is Visible    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]    timeout=5s
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Edit Link Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล Link
    Wait Until Element Is Visible    id=link    timeout=10s
    Input Text    id=link   https://www.github.com/

    # กดปุ่ม Update
    Scroll Element Into View    xpath=//button[contains(@class,'btn-dark') and text()='Update']
    Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark') and text()='Update']    timeout=10s
    Click Button    xpath=//button[contains(@class,'btn-dark') and text()='Update']

    # กดปุ่ม "ใช่, อัปเดตเลย!"
    Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']    timeout=5s
    Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']

    # รอให้กลับไปยังหน้า Manage Highlights
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s

    # ตรวจสอบว่ามีข้อความแจ้งเตือน "Highlight updated successfully!"
    Wait Until Element Is Visible    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]    timeout=5s
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Edit ImageAlbum Highlight

    # ไปยังหน้าจัดการ Highlights
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

    # ค้นหาและกดปุ่ม Edit ของ News อันแรก
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
    Click Element    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class, 'btn-outline-primary')][i[contains(@class, 'fa-edit')]]

    # แก้ไขข้อมูล ImageAlbum
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    D:/projectSoftEn/git-group-repository-group-4-sec-2/version3/test/Test-Data/1.png

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
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}

Click Home Icon
    Sleep    1s
    Wait Until Element Is Visible    xpath=//a[contains(@class, 'nav-link home-icon')]    timeout=10s
    Click Element    xpath=//a[contains(@class, 'nav-link home-icon')]
    Wait Until Location Is    ${URL}    ${DELAY}
    Sleep    1s



*** Test Cases ***
Test Edit Highlight
    [Tags]    UAT-V3-edittest
    [Documentation]    ทดสอบการแก้ไขข่าวและดูข่าวสำเร็จ
        
    Go To Manage Highlights Page
    # Edit CoverImage Highlight
    Edit Title Highlight
    # Edit Tag Highlight
    # Edit Description Highlight
    # Edit Link Highlight
    # Edit ImageAlbum Highlight
    Close Browser