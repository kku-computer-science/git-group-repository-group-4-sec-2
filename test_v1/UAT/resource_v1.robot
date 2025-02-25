*** Settings ***
# Documentation     A resource file with reusable keywords and variables.
# ...
# ...               The system specific keywords created here form our own
# ...               domain specific language. They utilize keywords provided
# ...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${BROWSER}       chrome
# สำหรับทดสอบ localhost
# ${LOCALHOST}     127.0.0.1:8000
${LOCALHOST}     localhost
${URL}           http://${LOCALHOST}/
${LOGIN_URL}     http://${LOCALHOST}/login
${DASHBOARD_URL}  http://${LOCALHOST}/dashboard
${MANAGE_HIGHLIGHTS_URL}    http://${LOCALHOST}/highlights
${CREATE_NEWS_URL}    http://${LOCALHOST}/highlights/create

# สำหรับทดสอบ host จริง
# ${HOST}          cs04sec267.cpkkuhost.com
# ${URL}           https://${HOST}/
# ${LOGIN_URL}     https://${HOST}/login
# ${DASHBOARD_URL}  https://${HOST}/dashboard
# ${MANAGE_HIGHLIGHTS_URL}    https://${HOST}/highlights
# ${CREATE_NEWS_URL}    https://${HOST}/highlights/create
${ADMIN_USERNAME}      admin@gmail.com
${ADMIN_PASSWORD}      12345678
${STAFF_USERNAME}      staff@gmail.com
${STAFF_PASSWORD}      123456789
${RESEARCHER_USERNAME}      thanaphon@kku.ac.th
${RESEARCHER_PASSWORD}      123456789
${INVALID_ADMIN_USERNAME}   staff@mail.com
${INVALID_PASSWORD}      111111111
${error_message}    Login Failed: Your user ID or password is incorrect
${DELAY}    2

${TITLE}          โครงการทุนวิจัยและโอกาสสนับสนุนสำหรับนักวิจัยรุ่นใหม่
${DESCRIPTION}    เปิดรับสมัครทุนวิจัยสำหรับนักวิจัยรุ่นใหม่ เพื่อสนับสนุนการพัฒนาโครงการวิจัยที่มีศักยภาพ

${CHROME_BROWSER_PATH}    /Users/fan/Desktop/ChromeForTesting/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing
${CHROME_DRIVER_PATH}     /Users/fan/Desktop/ChromeForTesting/chromedriver-mac-arm64/chromedriver

*** Keywords ***
Verify Admin Dashboard
    # ตรวจสอบเมนูเฉพาะของ Admin
    Page Should Contain    Users
    Page Should Contain    Roles
    Page Should Contain    Permission
    Page Should Contain    Manage Highlights

Verify Staff Dashboard
    # ตรวจสอบเมนูเฉพาะของ Staff
    # Page Should Contain    Departments
    # Page Should Contain    Manage Programs
    Page Should Contain    Manage Highlights

Verify Researcher Dashboard
    # Researcher ไม่มีเมนูพิเศษแบบ Admin หรือ Staff
    Page Should Not Contain    Users
    Page Should Not Contain    Roles
    Page Should Not Contain    Permission
    Page Should Not Contain    Departments
    Page Should Not Contain    Manage Programs
    Page Should Not Contain    Manage Highlights

# สำหรับ Test ไม่ผ่าน
# Verify Admin Dashboard
#     # ตรวจสอบเมนูเฉพาะของ Admin
#     Page Should Contain    Users
#     Page Should Contain    Roles
#     Page Should Contain    Permission
#     Page Should Contain    Manage Highlights

# Verify Staff Dashboard
#     # ตรวจสอบเมนูเฉพาะของ Staff
#     Page Should Contain    Departments
#     Page Should Contain    Manage Programs
#     Page Should Contain    Manage Highlights
#     Page Should Contain    Users

# Verify Researcher Dashboard
#     # Researcher ไม่มีเมนูพิเศษแบบ Admin หรือ Staff
#     Page Should Not Contain    User Profile
#     Page Should Not Contain    Users
#     Page Should Not Contain    Roles
#     Page Should Not Contain    Permission
#     Page Should Not Contain    Departments
#     Page Should Not Contain    Manage Programs
#     Page Should Not Contain    Manage Highlights

# Open Browser
#     # สร้าง options สำหรับ Chrome
#     ${chrome_options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()

#     # ตั้งค่า binary_location ให้กับ chrome_options
#     ${chrome_options.binary_location}    Set Variable    ${CHROME_BROWSER_PATH}

#     # สร้าง service สำหรับ chromedriver
#     ${service}    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path="${CHROME_DRIVER_PATH}")

#     # สร้าง WebDriver โดยใช้ options และ service
#     Create Webdriver    Chrome    options=${chrome_options}    service=${service}

#     Maximize Browser Window
#     Go To    ${URL}

Go To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # 1. เปิดเว็บไซต์ที่หน้าแรก
    Location Should Be    ${URL}
    # 2. คลิกปุ่ม Login
    # Click Link    xpath=//a[@class='btn-solid-sm' and text()='Login']
    Click Link    xpath=//a[contains(@class, 'btn-primary') and contains(., 'Login')]
    # <a class="btn btn-primary" href="http://localhost/login">Login</a>
    # สลับไปยังแท็บใหม่ถ้ามี target="_blank"
    # Switch Window    NEW
    Location Should Be    ${LOGIN_URL}
    Wait Until Page Contains    Account Login    ${DELAY}

Login Admin
    Input Text    id=username    ${ADMIN_USERNAME}
    Input Text    id=password    ${ADMIN_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Staff โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}

Login Staff
    Input Text    id=username    ${STAFF_USERNAME}
    Input Text    id=password    ${STAFF_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Staff โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}

Login Researcher
    Input Text    id=username    ${RESEARCHER_USERNAME}
    Input Text    id=password    ${RESEARCHER_PASSWORD}
    # 5. คลิกปุ่ม Log in
    Click Button    xpath=//button[contains(text(),'Log In')]
    # 6. รอจนกว่าหน้า Dashboard ของ Researcher โหลดเสร็จ
    Wait Until Location Is    ${DASHBOARD_URL}    ${DELAY}
    Wait Until Page Contains    Dashboard    ${DELAY}

Go To Manage Highlights Page
    Go To Login Page
    Login Staff
    Verify Staff Dashboard 
    # 7. คลิกปุ่ม Manage Highlights
    Click Link    xpath=//a[@class='nav-link' and contains(span, 'Manage Highlights')]
    Wait Until Location Is    ${MANAGE_HIGHLIGHTS_URL}    ${DELAY}
    Page Should Contain    Manage Highlights