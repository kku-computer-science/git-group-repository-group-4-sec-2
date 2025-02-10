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
# ${URL}           http://${LOCALHOST}/
# ${LOGIN_URL}     http://${LOCALHOST}/login
# ${DASHBOARD_URL}  http://${LOCALHOST}/dashboard
# ${MANAGE_HIGHLIGHTS_URL}    http://${LOCALHOST}/highlights
# สำหรับทดสอบ host จริง
${HOST}          cs04sec267.cpkkuhost.com
${URL}           https://${HOST}/
${LOGIN_URL}     https://${HOST}/login
${DASHBOARD_URL}  https://${HOST}/dashboard
${MANAGE_HIGHLIGHTS_URL}    https://${HOST}/highlights
${ADMIN_USERNAME}      admin@gmail.com
${ADMIN_PASSWORD}      12345678
${STAFF_USERNAME}      staff@gmail.com
${STAFF_PASSWORD}      123456789
${RESEARCHER_USERNAME}      thanaphon@kku.ac.th
${RESEARCHER_PASSWORD}      123456789
${DELAY}    2
*** Keywords ***
Verify Admin Dashboard
    # ตรวจสอบเมนูเฉพาะของ Admin
    Page Should Contain    Users
    Page Should Contain    Roles
    Page Should Contain    Permission

Verify Staff Dashboard
    # ตรวจสอบเมนูเฉพาะของ Staff
    Page Should Contain    Departments
    Page Should Contain    Manage Programs
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