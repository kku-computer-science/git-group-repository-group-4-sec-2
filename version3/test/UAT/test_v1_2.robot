*** Settings ***
Resource          C:\work_2025\git-group-repository-group-4-sec-2\version3\test\UAT\resource_v3.robot
Library           SeleniumLibrary

    
*** Variables ***


*** Test Cases ***
# Test Scenario ID:	UAT-V1-02
Test Login Role Staff Unsuccess
    [Documentation]    ทดสอบการ Login ของ Staff ไม่สำเร็จ
    Go To Login Page
    Input Text    id=username    ${ADMIN_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]    ${DELAY}
    Element Text Should Be    xpath=//div[contains(@class, 'alert-danger')]    ${error_message}
    Close Browser


Test Login Role Admin Unsuccess
    [Documentation]    ทดสอบการ Login ของ Admin ไม่สำเร็จ
    Go to Login Page
    Input Text    id=username    ${ADMIN_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]    ${DELAY}
    Element Text Should Be    xpath=//div[contains(@class, 'alert-danger')]    ${error_message}
    Close Browser

Test Login Role Researcher Unsuccess
    [Documentation]    ทดสอบการ Login ของ Researcher ไม่สำเร็จ
    Go to Login Page
    Input Text    id=username    ${RESEARCHER_USERNAME}
    Input Text    id=password    ${INVALID_PASSWORD}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Location Should Be    ${LOGIN_URL}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]    ${DELAY}
    Element Text Should Be    xpath=//div[contains(@class, 'alert-danger')]    ${error_message}
    Close Browser
  
