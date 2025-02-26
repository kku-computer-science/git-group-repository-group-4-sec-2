* Settings *
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

* Variables *

* Test Cases *

Test Go To Manage Highlights Page
    Go To Manage Highlights Page
    

Test Create News Unsuccess Empty Cover Image
    # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่รูปภาพ Cover Image
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    3s
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Sleep    1s

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();
    
    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาอัปโหลดรูปภาพ!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]
    Wait Until Location Is    ${CREATE_NEWS_URL}
    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser

Test Create News Unsuccess Empty Title:
    # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่ Title
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    3s
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg

    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Sleep    1s

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();

    Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณากรอกชื่อไฮไลท์!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser

#Test Create Unsuccess Empty TAG:
Test Create News Unsuccess Empty Tag:
    # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่เลือก Tag
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    3s
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();

    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาเลือก tag!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser

Test Create News Unsuccess Empty Description:
    # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่ Description
    Go To Manage Highlights Page
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Sleep    3s
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่

    Click Element   xpath=//span[contains(@class, 'select2-selection')]
    Sleep    1s
    Click Element    xpath=//li[contains(text(), 'ทุนวิจัยและโอกาสสนับสนุน')]
    Sleep    1s

    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
    Input Text    id=link   https://www.google.com
    
    Scroll Element Into View    id=imageAlbumBox
    Click Element    id=imageAlbumBox
    Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg\nC:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
    Scroll Element Into View    xpath=//button[@type='submit' and contains(text(),'Save')]

    # หรือใช้ Wait Until Element Is Visible ก่อนคลิก
    Wait Until Element Is Visible    xpath=//button[@type='submit' and contains(text(),'Save')]
    Execute JavaScript    document.querySelector("button.btn.btn-dark").click();
    Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณากรอกคำอธิบาย!
    Click Element    xpath=//button[contains(@class, 'swal2-confirm') and contains(text(),'ตกลง')]

    Location Should Be    ${CREATE_NEWS_URL}
    Close Browser