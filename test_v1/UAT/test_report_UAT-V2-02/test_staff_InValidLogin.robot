*** Settings ***
Resource          C:/work_2025/git-group-repository-group-4-sec-2/test_v1/UAT/resource_v1.robot

Suite Setup       Go To Login Page
Suite Teardown    Close Browser
Test Template     Form Should Fail

*** Variables ***

*** Test Cases ***                                      USERNAME                        PASSWORD
Test Login Role Staff Email incorrect                   ${INVALID_ADMIN_USERNAME}       ${STAFF_PASSWORD}
Test Login Role Staff Password incorrect                ${STAFF_USERNAME}               ${INVALID_PASSWORD}
Test Login Role Staff Email&Password incorrect          ${INVALID_ADMIN_USERNAME}       ${INVALID_PASSWORD}
Test Login Role Staff Email Is Empty                    ${EMPTY}                        ${STAFF_PASSWORD}
Test Login Role Staff Password Is Empty                 ${STAFF_USERNAME}               ${EMPTY}
Test Login Role Staff Email&Password Is Empty           ${EMPTY}                        ${STAFF_PASSWORD}

*** Keywords ***
# Test Scenario ID:	UAT-V2-02
Form Should Fail
    [Arguments]    ${username}    ${password}
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Button    xpath=//button[contains(text(),'Log In')]
    Form Should Have Fail

Form Should Have Fail
    Location Should Be    ${LOGIN_URL}
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'alert-danger')]    ${DELAY}
    Element Text Should Be    xpath=//div[contains(@class, 'alert-danger')]    ${error_message}