*** Settings ***
Library           SeleniumLibrary
Resource          ${CURDIR}/../Resources/common.robot
Suite Setup       Open Browser to    https://www.saucedemo.com/
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}             HeadlessChrome
${USERNAME}            standard_user
${PASSWORD}            secret_sauce
${USERNAME_FIELD}      //*[@id="user-name"]
${PASSWORD_FIELD}      //*[@id="password"]
${LOGIN_BTN_FIELD}     //*[@id="login-button"]

*** Test Cases ***
As a User I Want to Open Web Sauce Demo
    Input Text  ${USERNAME_FIELD}    ${USERNAME}
    Input Password  ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button  ${LOGIN_BTN_FIELD}
    Sleep  1
    [Teardown]  Close Browser
