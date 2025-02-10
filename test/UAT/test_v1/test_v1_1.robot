*** Settings ***
Resource          ./test_resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test Go to Login Page
    [Documentation]    ทดสอบการเข้าหน้า Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}
    Close Browser
Test Login Role Admin Success
    [Documentation]    ทดสอบการ Login ของ Admin สำเร็จ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
     # 3. รอให้หน้า Login โหลดเสร็จ
    Wait Until Location Is    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}
    # Wait Until Element Is Visible    id=username    ${DELAY}
    # 4. กรอก username และ password
    Input Text    id=username    ${ADMIN_USERNAME}
    Input Text    id=password    ${ADMIN_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Staff โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}
    Verify Admin Dashboard
    Close Browser
    Close Browser

Test Login Role Staff Success
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
     # 3. รอให้หน้า Login โหลดเสร็จ
    Wait Until Location Is    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}
    # Wait Until Element Is Visible    id=username    ${DELAY}
    # 4. กรอก username และ password
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Staff โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}
    Verify Staff Dashboard
    Close Browser
    Close Browser

Test Login Role Researcher Success
    [Documentation]    ทดสอบการ Login ของ Researcher สำเร็จ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
     # 3. รอให้หน้า Login โหลดเสร็จ
    Wait Until Location Is    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}
    # Wait Until Element Is Visible    id=username    ${DELAY}
    # 4. กรอก username และ password
    Input Text    id=username    ${RESEARCHER_USERNAME}
    Input Text    id=password    ${RESEARCHER_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Researcher โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}
    Verify Researcher Dashboard
    Close Browser
    Close Browser

Test Go to Manage Highlights Page
    [Documentation]    ทดสอบการเข้าหน้า Manage Highlights
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
     # 3. รอให้หน้า Login โหลดเสร็จ
    Wait Until Location Is    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}
    # Wait Until Element Is Visible    id=username    ${DELAY}
    # 4. กรอก username และ password
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Staff โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}
    Verify Staff Dashboard
    # 7. คลิกปุ่ม Manage Highlights
    Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
    Page Should Contain    Manage Highlights
    Close Browser
    Close Browser
