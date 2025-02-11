*** Settings ***
Resource          ./resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***

Test Open Home Page
    [Documentation]    ทดสอบการเปิดเว็บไซต์
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Close Browser

Test Go To Login Page
    [Documentation]    ทดสอบการเข้าหน้า Login
    Go To Login Page
    Close Browser
    
Test Login Role Admin Success
    [Documentation]    ทดสอบการ Login ของ Admin สำเร็จ
    Go To Login Page
    Login Admin
    Verify Admin Dashboard
    Close Browser

Test Login Role Staff Success
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    Close Browser

Test Login Role Researcher Success
    [Documentation]    ทดสอบการ Login ของ Researcher สำเร็จ
    Go To Login Page
    Login Researcher
    Verify Researcher Dashboard
    Close Browser

Test Go To Manage Highlights Page
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ และเข้าหน้า Manage Highlights
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    # 7. คลิกปุ่ม Manage Highlights
    Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
    Page Should Contain    Manage Highlights
    Close Browser
