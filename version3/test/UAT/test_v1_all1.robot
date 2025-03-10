*** Settings ***
Resource          C:\work_2025\git-group-repository-group-4-sec-2\version3\test\UAT\resource_v3.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***

# Test Scenario ID:	UAT-V1-01
Test Open Home Page
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการเปิดเว็บไซต์
    Open Browser
    Maximize Browser Window
    Close Browser

Test Go To Login Page
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการเข้าหน้า Login
    Go To Login Page
    Close Browser
    
Test Login Role Admin Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Admin สำเร็จ
    Go To Login Page
    Login Admin
    Verify Admin Dashboard
    Close Browser

Test Login Role Staff Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    Close Browser

Test Login Role Researcher Success
     # ✅ Passed
    [Tags]    UAT-V1-01
    [Documentation]    ทดสอบการ Login ของ Researcher สำเร็จ
    Go To Login Page
    Login Researcher
    Verify Researcher Dashboard
    Close Browser