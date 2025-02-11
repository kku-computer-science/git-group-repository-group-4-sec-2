*** Settings ***
Resource          ./resource_v1.robot
Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test Login Role Staff success
    [Documentation]    ทดสอบการ Login ของ Staff สำเร็จ
    Go To Login Page
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Wait Until Location Is    ${DASHBOARD_URL}    timeout=5s

Test DASHBOARD To MANAGE HIGHLIGHTS
    Location Should Be    ${DASHBOARD_URL}
    Click Element    xpath=//span[contains(text(),'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}   

Test Click +Create MANAGE HIGHLIGHTS
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(text(), 'Create')]
    Wait Until Location Is    ${HIGHLIGHTS_CREATE_URL}    ${DELAY}

Test Create HIGHLIGHTS
    Click Element    id=coverImageBox
    Choose File    id=cover_image
    Select From List By Value    id=category
    Input Text    id=title
    Input Text    id=detail
    Click Button    xpath=//button[contains(text(),'Save')]
     Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
