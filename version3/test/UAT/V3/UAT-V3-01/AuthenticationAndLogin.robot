*** Settings ***
Resource            ../../resource_v3.robot
# Library           SeleniumLibrary

*** Variables ***

*** Keywords ***
Form Should Have Fail
    Location Should Be    ${LOGIN_URL}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]    ${DELAY}
    Element Text Should Be    xpath=//div[contains(@class, 'alert-danger')]    ${error_message}

*** Test Cases ***

Test Open Home Page
     # ✅ Passed
    [Tags]    UAT-V3-01
    [Documentation]    ทดสอบการเปิดเว็บไซต์
    Open Chrome Browser
    Maximize Browser Window
    Close Browser

Test Go To Login Page
     # ✅ Passed
    [Tags]    UAT-V3-01
    [Documentation]    ทดสอบการเข้าหน้า Login
    Go To Login Page
    Close Browser
    
Test Login Role Staff Success
     # ✅ Passed
    [Tags]    UAT-V3-01
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Login Staff
    Verify Staff Dashboard
    Close Browser

Test Login Role Staff Email incorrect
    Go To Login Page
    Input Text    id=username    ${INVALID_ADMIN_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Form Should Have Fail
    Close Browser

Test Login Role Staff Password incorrect
    Go To Login Page
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD} 
    Click Button    xpath=//button[contains(text(),'Log In')]
    Form Should Have Fail
    Close Browser

Test Login Role Staff Email&Password incorrect
    Go To Login Page
    Input Text    id=username    ${INVALID_ADMIN_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD} 
    Click Button    xpath=//button[contains(text(),'Log In')]
    Form Should Have Fail
    Close Browser

Test Login Role Staff Email Is Empty
    Go To Login Page
    Input Text    id=username    ${EMPTY}
    Input Text    id=password    ${STAFF_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Close Browser

Test Login Role Staff Password Is Empty
    Go To Login Page
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${EMPTY}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Close Browser

Test Login Role Staff Email&Password Is Empty
    Go To Login Page
    Input Text    id=username    ${EMPTY}
    Input Text    id=password    ${EMPTY}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Close Browser
