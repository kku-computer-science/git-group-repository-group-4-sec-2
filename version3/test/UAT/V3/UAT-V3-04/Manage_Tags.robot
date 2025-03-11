*** Settings ***
Resource          /Users/fan/Desktop/myGitLocal/git-group-repository-group-4-sec-2/version3/test/UAT/resource_v3.robot

*** Variables ***
${CREATE_BUTTON}    xpath=//a[@data-bs-target='#createTagModal'][contains(text(), 'Create')]
${EXPECTED_TAG}    ผลงานยอดรางวัล
${NEW_EXPECTED_TAG}    ผลงานเด่นยอดรางวัล
${TAG_INPUT}      id=tagName
${SAVE_BUTTON}     xpath=//button[contains(text(), 'Save')]
${CREATE_SUCCESS_MESSAGE}    สร้าง Tag สำเร็จ!
${EDIT_TAG_INPUT}    id=editTagName
${UPDATE_BUTTON}    xpath=//button[contains(text(), 'Update')]
${DELETE_SUCCESS_MESSAGE}    ลบสำเร็จ!

*** Keywords ***
Refresh Page Once
    Reload Page
    Sleep    2s  # รอให้หน้าโหลดเสร็จ

Click Create Button
    Wait Until Element Is Visible    ${CREATE_BUTTON}    timeout=5s
    Scroll Element Into View    ${CREATE_BUTTON}
    Click Element    ${CREATE_BUTTON}
    Wait Until Element Is Visible    id=createTagModal    timeout=5s  # ✅ รอ Modal โผล่ขึ้นมาก่อน


Input Tag Name
    Wait Until Element Is Visible    ${TAG_INPUT}    timeout= 15s
    Scroll Element Into View    ${TAG_INPUT}
    Execute JavaScript    document.getElementById('tagName').value='${EXPECTED_TAG}';

Click Save Button
    Wait Until Element Is Visible    ${SAVE_BUTTON}    timeout=5s
    Scroll Element Into View    ${SAVE_BUTTON}
    Execute JavaScript    document.evaluate("//button[contains(text(), 'Save')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

Verify Tag Creation
    Wait Until Page Contains    ${CREATE_SUCCESS_MESSAGE}
    Sleep    2s

Check Data Create
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Refresh Page Once
    Wait Until Page Contains    ${EXPECTED_TAG}

Input New Tag Name
    Wait Until Element Is Visible    ${EDIT_TAG_INPUT}    timeout= 15s
    Scroll Element Into View    ${EDIT_TAG_INPUT}
    Execute JavaScript    document.getElementById('editTagName').value='${NEW_EXPECTED_TAG}';

Click Update Button
    Wait Until Element Is Visible    ${UPDATE_BUTTON}    timeout=5s
    Scroll Element Into View    ${UPDATE_BUTTON}
    Execute JavaScript    document.evaluate("//button[contains(text(), 'Update')]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

Verify Tag Edit
    Wait Until Page Contains    แก้ไข Tag สำเร็จ!
    Sleep    2s

Check Data Edit
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Refresh Page Once
    Wait Until Page Contains    ${NEW_EXPECTED_TAG}

Verrify Tag Delete
    Wait Until Page Contains    ${DELETE_SUCCESS_MESSAGE}
    Sleep    2s

Check Data Delete
    Location Should Be    ${MANAGE_HIGHLIGHTS_URL}
    Refresh Page Once
    Wait Until Keyword Succeeds    10x    1s    Page Should Not Contain    ${NEW_EXPECTED_TAG}

*** Test Cases ***

Test Go To Manage Highlights Page
    Go To Manage Highlights Page
    Close Browser

Test Create Tag

    Go To Manage Highlights Page

    Click Create Button

    Input Tag Name

    Click Save Button

    Verify Tag Creation

    Check Data Create
    
    Close Browser

Test Edit Tag

    Go To Manage Highlights Page

    Execute JavaScript    document.querySelector("button.btn-edit[data-name='ผลงานยอดรางวัล']").click();
    
    Input New Tag Name

    Click Update Button

    Verify Tag Edit

    Check Data Edit

    Close Browser

Test Delete Tag

    Go To Manage Highlights Page

    Execute JavaScript    document.querySelector("tr:has(button[data-name='ผลงานเด่นยอดรางวัล']) button.delete-tag-btn").click();
    Sleep    2s

    # ✅ รอให้ปุ่ม "ใช่, ลบเลย!" แสดงขึ้นมา
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'swal2-confirm')]    timeout=5s
    Sleep    1s

    # ✅ กดปุ่ม "ใช่, ลบเลย!" เพื่อยืนยัน
    Execute JavaScript    document.querySelector("button.swal2-confirm").click();
    Sleep    2s

    Verrify Tag Delete

    Check Data Delete

    Close Browser
