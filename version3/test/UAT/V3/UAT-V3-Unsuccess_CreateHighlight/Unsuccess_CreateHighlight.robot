*** Settings ***
Resource          ../../resource_v3.robot
Library          Collections

*** Variables ***
${NEWS_ID}
${ADD_HIGHLIGHT_BTN}
${HOME_HIGHLIGHT_IMAGE_XPATH}    xpath=//div[@id='highlightNews']//img
${COVER_IMAGE}    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
${ALBUM_IMAGES}    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
${DESCRIPTION_TEXT}    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
${LINK_TEXT}    https://www.google.com

*** Test Cases ***
Test Create News With All Error Cases
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวโดยไล่ตรวจสอบแต่ละข้อผิดพลาดแบบต่อเนื่อง ไม่ปิด Browser
    
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    3s
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}
    
    # กรณีที่ 1: ไม่ใส่ Cover Image
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Input Text    id=description    ${DESCRIPTION_TEXT}
    Input Text    id=link    ${LINK_TEXT}
    Choose File    id=image_album    ${ALBUM_IMAGES}
    
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click()

    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาอัปโหลดรูปภาพ!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    # กรณีที่ 2: ใส่ Cover Image แต่ไม่ใส่ Title
    Choose File    xpath=//input[@type='file']    ${COVER_IMAGE}
    Clear Element Text    id=title  # ลบ Title ออกเพื่อให้เกิด Error
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click()
    
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณากรอกชื่อไฮไลท์!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    # กรณีที่ 3: ใส่ Title แต่ไม่เลือก Tag
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click()
    
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาเลือก tag!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    # กรณีที่ 4: เลือก Tag แต่ไม่ใส่ Description
    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Clear Element Text    id=description  # ลบ Description ออก
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click()

    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณากรอกคำอธิบาย!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    # ปิด Browser หลังจากทดสอบครบทุกกรณี
    Close Browser
