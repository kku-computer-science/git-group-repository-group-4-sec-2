*** Settings ***
Resource          ./resource_v1.robot
Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test Add News to Highlights
    [Documentation]    แสดง popup “สร้างข่าวสำเร็จ” กลับไปยังหน้า Manage Highlights และข่าวที่สร้างถูกเพิ่มไปยังตาราง News
    Go To Manage Highlights Page
    
    # ค้นหาข้อมูล News ที่ต้องการเพิ่มไปยัง Highlights (เลือกอันแรกสุด)
    ${NEWS_ID}    Get Text    xpath=(//table[@id='news-table']//tr[1]//td[1])[1]
    
    # เลื่อน Scroll ไปที่ปุ่ม ADD ของ News อันแรก
    Scroll Element Into View    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
    
    # รอจนกว่าปุ่ม ADD จะมองเห็นและคลิก
    Wait Until Element Is Visible    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]    timeout=5s
    Click Button    xpath=(//table[@id='news-table']//tr[td[contains(text(),'${NEWS_ID}')]]//button[contains(@class,'btn-add')])[1]
    
    # รอให้ Popup แจ้งเตือนปรากฏว่าเพิ่มลงใน Highlights
    Wait Until Element Is Visible    xpath=//div[contains(@class,'swal2-popup')]//h2[contains(text(),'เพิ่มลงใน Highlights แล้ว!')]    timeout=5s
    
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




    