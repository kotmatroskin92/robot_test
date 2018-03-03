*** Settings ***
Documentation    Test demo REST service
Library    String
Library    demo_rest.DemoREST


*** Variables ***
${VALID_NAME}=             User123
${VALID_PASSWORD}=         Pass123
${STATUS_OK}=              200
${STATUS_UNAUTHORIZED}=    401
${NUMBER_OF_LINES}=        2

*** Test Cases ***
Auth Request Positive
    [Documentation]    Check status_code from request after login attempt
    ...                with credentials specified in Template's tags
    [Template]   Login with ${base_name}, ${base_password} and ${check_name}, ${check_password} and check ${status_code}

    ${VALID_NAME}    ${VALID_PASSWORD}    ${VALID_NAME}    ${VALID_PASSWORD}    ${STATUS_OK}
    us@43!_er        ${VALID_PASSWORD}    us@43!_er        ${VALID_PASSWORD}    ${STATUS_OK}
    us@43!_er        pas@!_s              us@43!_er        pas@!_s              ${STATUS_OK}

Auth Request Negative
    [Documentation]    Check status_code from request after login attempt
    ...                with credentials specified in Template's tags
    [Template]   Login with ${base_name}, ${base_password} and ${check_name}, ${check_password} and check ${status_code}

    ${VALID_NAME}    ${VALID_PASSWORD}    nameInvalid      passInvalid          ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    ${VALID_NAME}    passInvalid          ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    nameInvalid      ${VALID_PASSWORD}    ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    ${VALID_NAME}    ${EMPTY}             ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    nameInvalid      ${EMPTY}             ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    ${EMPTY}         ${VALID_PASSWORD}    ${STATUS_UNAUTHORIZED}
    ${VALID_NAME}    ${VALID_PASSWORD}    ${EMPTY}         passInvalid          ${STATUS_UNAUTHORIZED}

Count Responce Lines
    [Documentation]    Check number of lines in stream response is the same to a given one

    ${status_code}  ${json} =  Call Steam    ${number_of_lines}
    ${result} =  Get Line Count  ${json}
    Should Be Equal As Numbers   ${status_code}  ${STATUS_OK}

*** Keywords ***
Login with ${base_name}, ${base_password} and ${check_name}, ${check_password} and check ${status_code}
    [Documentation]    Check status_code from request after login attempt\n
    ...                with credentials

    ${st_code} =  Call Basic Auth  ${base_name}  ${base_password}  ${check_name}  ${check_password}
    Should Be Equal As Numbers   ${st_code}  ${status_code}
