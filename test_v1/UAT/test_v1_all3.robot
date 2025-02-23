*** Settings ***
Resource          ./resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
# Test Scenario ID:	UAT-V1-03
# Test Go To Manage Highlights Page
#      # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ และเข้าหน้า Manage Highlights
#     Go To Login Page
#     Login Staff
#     Verify Staff Dashboard
#     # 7. คลิกปุ่ม Manage Highlights
#     Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
#     Page Should Contain    Manage Highlights
#     Close Browser

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
    Choose File    xpath=//input[@type='file']    C:/Users/User/Pictures/Screenshots/Screenshot_2025-02-18_215543.png
    Sleep    2s
    # ซ่อน dialog ของ choose file
    Execute JavaScript    document.querySelector('input[type="file"]').blur()

    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Select From List By Label    id=category    ทุนวิจัยและโอกาสสนับสนุน
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ

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
    Close Browser

# Test Create News Success
#     # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการสร้างข่าวใหม่สำเร็จ
#     Go To Manage Highlights Page
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
#     Location Should Be    ${CREATE_NEWS_URL}
#     Click Element    id=coverImageBox
#     Choose File    xpath=//input[@type='file']    D:/projectSoftEn/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
#     Select From List By Value    id=category    1
#     Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
#     Scroll Element Into View    id=imageAlbumBox
#     Wait Until Element Is Visible    id=imageAlbumBox    timeout=5s
#     # Wait Until Element Is Visible    id=image_album    timeout=5s
#     # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
#     Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
#     Execute JavaScript    document.getElementById("image_album").style.display = "block";
#     # ใช้ Send Keys แทนการใช้ Choose File
#     Input Text    id=image_album    D:/projectSoftEn/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_2.jpeg
#     # รอให้ไฟล์โหลดเสร็จ
#     Sleep    2s
#     # ซ่อน dialog ของ choose file
#     Execute JavaScript    document.querySelector('input[type="file"]').blur()
#     # เลื่อนหน้าไปยังปุ่ม Save
#     Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
#     # เลื่อนไปยังปุ่ม Save
#     Scroll Element Into View    xpath=//button[contains(text(),'Save')]
#     # รอจนกว่าปุ่ม Save จะปรากฏ
#     Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
#     # รอจนกว่าปุ่ม Save จะพร้อมคลิก
#     Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
#     # คลิกปุ่ม Save
#     Click Button    xpath=//button[contains(text(),'Save')]
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
#     Close Browser

# Test Create News Unsuccess Empty Cover Image
#     # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่รูปภาพ Cover Image
#     Go To Manage Highlights Page
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
#     Location Should Be    ${CREATE_NEWS_URL}
#     # Test load cover img
#     # Click Element    id=coverImageBox
#     # Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
#     Select From List By Value    id=category    1
#     Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
#     # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
#     Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
#     Execute JavaScript    document.getElementById("image_album").style.display = "block";
#     # รอให้ input file ปรากฏจริง
#     Wait Until Element Is Visible    id=image_album    timeout=10s
#     # ใช้ Send Keys แทนการใช้ Choose File
#     Input Text    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     # รอให้ไฟล์โหลดเสร็จ
#     Sleep    2s
#      # เลื่อนไปยังปุ่ม Save
#     Scroll Element Into View    xpath=//button[contains(text(),'Save')]
#     # รอจนกว่าปุ่ม Save จะปรากฏ
#     Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
#     # รอจนกว่าปุ่ม Save จะพร้อมคลิก
#     Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
#     # รอจนกว่าจะมีการบันทึก
#     Click Button    xpath=//button[contains(text(),'Save')]
#     # ตรวจสอบว่าป๊อปอัพแสดงข้อความ "กรุณาอัปโหลดรูปภาพ!"
#     Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาอัปโหลดรูปภาพ!
#     # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
#     Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
#     Close Browser

# Test Create News Unsuccess Empty Title:
#     # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่ใส่ Title
#     Go To Manage Highlights Page
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
#     Location Should Be    ${CREATE_NEWS_URL}
#     Click Element    id=coverImageBox
#     Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     # Input Text    id=title    ""
#     Sleep    2s
#     Scroll Element Into View    id=category
#     # Wait Until Element Is Visible    id=category    timeout=5s
#     # Wait Until Element Is Enabled    id=category    timeout=5s
#     # Click Element    id=category
#     Select From List By Value    id=category    1
#     Scroll Element Into View    id=description
#     Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
#     # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
#     Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
#     Execute JavaScript    document.getElementById("image_album").style.display = "block";
#     # รอให้ input file ปรากฏจริง
#     Wait Until Element Is Visible    id=image_album    timeout=10s
#     # ใช้ Send Keys แทนการใช้ Choose File
#     Choose File    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     Sleep    2s
#     # เลื่อนไปยังปุ่ม Save
#     Scroll Element Into View    xpath=//button[contains(text(),'Save')]
#     # รอจนกว่าปุ่ม Save จะปรากฏ
#     Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
#     # รอจนกว่าปุ่ม Save จะพร้อมคลิก
#     Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
#     # รอจนกว่าจะมีการบันทึก
#     Click Button    xpath=//button[contains(text(),'Save')]
#     Click Button    xpath=//button[contains(text(),'Save')]
#     Sleep    1s  # รอให้แจ้งเตือนแสดง
#     Run Keyword And Continue On Failure    Element Should Be Visible    xpath=//input[@id='title'][@required]
#     # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
#     Location Should Be    ${CREATE_NEWS_URL}
#     Close Browser

# Test Create News Unsuccess Empty Category:
#     # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการสร้างข่าวใหม่ไม่สำเร็จ เนื่องจากไม่เลือก Category
#     Go To Manage Highlights Page
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
#     Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
#     Location Should Be    ${CREATE_NEWS_URL}
#      Click Element    id=coverImageBox
#      Choose File    xpath=//input[@type='file']    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
#     # Select From List By Label    id=category    1
#     Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ
#     # ลบ class 'd-none' จาก element และทำให้ input file แสดงขึ้น
#     Execute JavaScript    document.getElementById("image_album").classList.remove("d-none");
#     Execute JavaScript    document.getElementById("image_album").style.display = "block";
#     # รอให้ input file ปรากฏจริง
#     Wait Until Element Is Visible    id=image_album    timeout=10s
#     # ใช้ Send Keys แทนการใช้ Choose File
#     Input Text    id=image_album    C:/work_2025/git-group-repository-group-4-sec-2/test_v1/Test-Data/1_1.jpeg
#     Sleep    2s
# # เลื่อนไปยังปุ่ม Save
#     Scroll Element Into View    xpath=//button[contains(text(),'Save')]
#     # รอจนกว่าปุ่ม Save จะปรากฏ
#     Wait Until Element Is Visible    xpath=//button[contains(text(),'Save')]    timeout=5s
#     # รอจนกว่าปุ่ม Save จะพร้อมคลิก
#     Wait Until Element Is Enabled    xpath=//button[contains(text(),'Save')]    timeout=10s
#     # รอจนกว่าจะมีการบันทึก
#     Click Button    xpath=//button[contains(text(),'Save')]
#     # ตรวจสอบว่าแสดงป๊อปอัพที่มีข้อความ "โปรดกรอกฟิลด์นี้"
#     Wait Until Element Is Visible    xpath=//h2[@id='swal2-title']    timeout=5s
# # ตรวจสอบว่าแสดงข้อความ "กรุณาเลือกหมวดหมู่!"
#     Element Should Contain    xpath=//h2[@id='swal2-title']    กรุณาเลือกหมวดหมู่!
# # ตรวจสอบข้อความในส่วนของรายละเอียด
#     Element Should Contain    xpath=//div[@class='swal2-html-container']    คุณต้องเลือกหมวดหมู่ก่อนส่งแบบฟอร์ม
# # รอจนกว่าป๊อปอัพจะปรากฏ
#     Wait Until Element Is Visible    xpath=//button[@class='swal2-confirm swal2-styled swal2-default-outline']    timeout=5s
# # คลิกปุ่ม "ตกลง" ในป๊อปอัพ
#     Click Button    xpath=//button[@class='swal2-confirm swal2-styled swal2-default-outline']
#     # เช็คว่าเราอยู่ในหน้า Create News หลังจากแสดงป๊อปอัพ
#     Location Should Be    ${CREATE_NEWS_URL}
#     Close Browser

# Test Edit News:
#      # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการแก้ไขข่าว
#     Go To Manage Highlights Page
#     # ค้นหาและกดปุ่ม Edit ของ News อันแรก
#     ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
#     Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
#     Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]    timeout=5s
#     Click Element    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//a[contains(@class,'btn-outline-primary')])[1]
#     # แก้ไขข้อมูล Title
#     Scroll Element Into View    id=title
#     Wait Until Element Is Visible    id=title    timeout=5s
#     Wait Until Element Is Enabled    id=title    timeout=5s
#     Input Text    id=title    ${TITLE}
#     # กดปุ่ม Update
#     # กดปุ่ม Update
#     Scroll Element Into View    xpath=//button[contains(@class,'btn-dark') and text()='Update']
#     Wait Until Element Is Visible    xpath=//button[contains(@class,'btn-dark') and text()='Update']    timeout=5s
#     Click Button    xpath=//button[contains(@class,'btn-dark') and text()='Update']
#     # กดปุ่ม "ใช่, อัปเดตเลย!"
#     Wait Until Element Is Visible    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']    timeout=5s
#     Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, อัปเดตเลย!']
#     # รอให้กลับไปยังหน้า Manage Highlights
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s
#     # ตรวจสอบว่ามีข้อความแจ้งเตือน "Highlight updated successfully!"
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'alert-success') and contains(text(),'Highlight updated successfully!')]    timeout=5s


# Test Delete News
#      # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการลบข่าว
#     Go To Manage Highlights Page
#     # ค้นหา ID ของ News ที่ต้องการลบ (เลือกอันแรกสุด)
#     ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr/td[1])[1]
#     # เลื่อน Scroll ไปที่ปุ่มลบของ News อันแรก
#     Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
#     Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]//button[contains(@class,'btn-delete')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏ
#     Wait Until Element Is Visible    xpath=//h2[@id='swal2-title' and text()='คุณแน่ใจหรือไม่?']    timeout=5s
#     # กดปุ่ม "ใช่, ลบเลย!"
#     Click Button    xpath=//button[contains(@class,'swal2-confirm') and text()='ใช่, ลบเลย!']
#     # รอให้หน้าเปลี่ยนกลับไปยัง Manage Highlights
#     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    timeout=10s
#     # รอให้แถวที่มี ID ที่ถูกลบหายไปจริงๆ
#     Wait Until Element Is Not Visible    xpath=//table[@id='news-table']//tr[td[1][text()='${NEWS_ID}']]    timeout=10s

# Test Remove News Form Highlights
#      # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการนำข่าวออกจาก Highlights
#     Go To Manage Highlights Page
#     # ค้นหา ID ของ News ที่ต้องการนำออกจาก Highlights (เลือกอันแรกสุด)
#     ${HIGHLIGHT_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
#     # เลื่อน Scroll ไปที่ปุ่ม REMOVE ของ Highlight อันแรก
#     Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
#     Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏ
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'นำออกจาก Highlights แล้ว!')]    timeout=5s
#     # รอให้ Highlight หายไปจากตาราง Highlights
#     Wait Until Element Is Not Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${HIGHLIGHT_ID}']]    timeout=10s
#     # รอให้ตารางอัปเดตก่อนตรวจสอบ
#     Sleep    2s  
#     # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง News อย่างถูกต้อง
#     Wait Until Element Is Visible    xpath=//table[@id='news-table']//tr/td[1][normalize-space(text())='${HIGHLIGHT_ID}']    timeout=10s

Test Add News to Highlights
     # ✅ Passed
    [Tags]    UAT-V1-03
    [Documentation]    ทดสอบการมีข่าวแล้วนำเข้า Highlights
    Go To Manage Highlights Page
    
    # เพิ่มข่าว
    Scroll Element Into View    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Click Link    xpath=//a[contains(text(), '+ Create')]
    Wait Until Location Is    ${CREATE_NEWS_URL}    ${DELAY}
    Location Should Be    ${CREATE_NEWS_URL}

    Click Element    id=coverImageBox
    Choose File    xpath=//input[@type='file']    C:/Users/User/Pictures/Screenshots/Screenshot_2025-02-18_215543.png
    Input Text    id=title    โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
    Select From List By Label    id=category    ทุนวิจัยและโอกาสสนับสนุน
    Input Text    id=description    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ

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

    # ค้นหาข้อมูล News ที่ต้องการเพิ่มไปยัง Highlights (เลือกอันแรกสุด)
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[1]//td[1])[1]
    # เลื่อน Scroll ไปที่ปุ่ม ADD ของ News อันแรก
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
    # รอจนกว่าปุ่ม ADD จะมองเห็นและคลิก
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s
    Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
    # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Highlights
    Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=10s
    # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
    Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s
    # รอให้ตารางอัปเดตก่อนตรวจสอบ
    Sleep    2s
    # ตรวจสอบว่า ID ถูกเพิ่มลงในตาราง highlight-table
    ${highlight_table_row}=    Get Text    xpath=//table[@id='highlight-table']//tr[td[contains(text(),'${NEWS_ID}')]]
    Should Contain    ${highlight_table_row}    ${NEWS_ID}
    Should Contain    ${highlight_table_row}    REMOVE  # ตรวจสอบว่าแถวมีปุ่ม REMOVE
    # ตรวจสอบว่า ${NEWS_ID} ไม่มีอยู่ในตาราง news-table อีกแล้ว
    ${news_table_row}=    Run Keyword And Return Status    Get Text    xpath=//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]
    Should Not Be Equal    ${news_table_row}    ${NEWS_ID}    # ตรวจสอบว่า ${NEWS_ID} ไม่ปรากฏในตาราง news-table
   
    # ลบ highlight
    # ค้นหา ID ของ News ที่ต้องการนำออกจาก Highlights (เลือกอันแรกสุด)
    ${HIGHLIGHT_ID}    Get Text    xpath=(//table[@id='highlight-table']//tr/td[1])[1]
    # เลื่อน Scroll ไปที่ปุ่ม REMOVE ของ Highlight อันแรก
    Scroll Element Into View    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
    Wait Until Element Is Visible    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]    timeout=5s
    Click Button    xpath=(//table[@id='highlight-table']//tr[td[contains(text(),'${HIGHLIGHT_ID}')]]//button[contains(@class,'btn-remove')])[1]
    # รอให้ Popup แจ้งเตือนปรากฏ
    Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'นำออกจาก Highlights แล้ว!')]    timeout=5s
    # รอให้ Highlight หายไปจากตาราง Highlights
    Wait Until Element Is Not Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${HIGHLIGHT_ID}']]    timeout=10s
    # รอให้ตารางอัปเดตก่อนตรวจสอบ
    Sleep    2s

    Close Browser


# Test Add News To Full Highlights
#      # ✅ Passed
#     [Tags]    UAT-V1-03
#     [Documentation]    ทดสอบการเพิ่มข่าวเข้า Highlights เมื่อ Highlights เต็ม
#     Go To Manage Highlights Page
#     # ตรวจสอบว่าปุ่ม "ADD" ถูกปิดใช้งาน (disabled) เมื่อ Highlights เต็ม
#     ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[1]//td[1])[1]
#     Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
#     # รอจนกว่าปุ่ม ADD จะมองเห็นและคลิก
#     Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s
#     Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
#     # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Highlights
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=10s
#     # รอให้ ID ถูกเพิ่มลงในตาราง highlight-table
#     Wait Until Element Is Visible    xpath=//table[@id='highlight-table']//tr[td[normalize-space(text())='${NEWS_ID}']]    timeout=10s
#     # รอให้ตารางอัปเดตก่อนตรวจสอบ
#     Sleep    2s
#     ${ADD_BUTTON_STATE}    Get Element Attribute    xpath=(//table[@id='news-table']//tr[1]//button[contains(@class,'btn-add')])[1]    disabled   
#     Should Be Equal As Strings    ${ADD_BUTTON_STATE}    true
#     Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
#     Close Browser
