*** Settings ***
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot
# Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***

# Test Scenario ID:	UAT-V2-01
Test Open Home Page
     # ✅ Passed
    [Tags]    UAT-V2-01
    [Documentation]    ทดสอบการเปิดเว็บไซต์
    Open Browser
    Maximize Browser Window
    Close Browser

Test Go To Login Page
     # ✅ Passed
    [Tags]    UAT-V2-01
    [Documentation]    ทดสอบการเข้าหน้า Login
    Go To Login Page
    Close Browser
    
Test Login Role Staff Success
     # ✅ Passed
    [Tags]    UAT-V2-01
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    Close Browser

