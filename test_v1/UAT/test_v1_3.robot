*** Settings ***
Resource          ./resource_v1.robot
Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test Login Role Staff success
    [Documentation]    ทดสอบการ Login ของ Staff ไม่สำเร็จ
    Go to Login Page
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${DASHBOARD_URL}

Test DASHBOARD To MANAGE HIGHLIGHTS
    Location Should Be    ${DASHBOARD_URL}
    Click Element    xpath=//a[contains(text(),'Manage Highlights')]
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
