*** Settings ***
Library           RPA.Browser    run_on_failure=none    timeout=30    implicit_wait=10
Resource          ../DATA/Locators.robot
Library           String
Library           OperatingSystem
Library           RPA.HTTP
Library           DateTime
Library           Process
Library           ExcelLibrary
Library           RPA.Excel.Files

*** Keywords ***
Create File And Get Times
    ${path}    Replace String    ${CURDIR}    GLOBAL    DATA
    Set Global Variable    ${path}
    ${newpath}    Replace String    ${CURDIR}    GLOBAL    ${EMPTY}
    Set Global Variable    ${newpath}
    Get Time
    Create File    ${path}${Rp_Prefix}    Check Alive Lotte\n${time}\r\n
    Comment    Append Content To File    ${title}\r\n${time}\r\n
    Set Selenium Speed    0.2
    Comment    Set Selenium Timeout    30
    Comment    Set Selenium Implicit Wait    10
    My Create New Final Report

Count Times And Close
    ${end_time}    Get Current Date
    ${finish_time}    Subtract Date From Date    ${end_time}    ${start_time}    compact    true
    Append Content To File    \nFinished in ${finish_time}\r\n
    Close All Browsers
    Comment    ${call_rp}    Set Variable    cd ${path} && python check_alive_lotte.py
    Comment    ${log}    Run Process    ${call_rp}    shell=True    timeout=120s    on_timeout=continue
    Comment    Log    ${log.stdout}

Go To Home Page
    Open Home Page
    Login With Valid Data

Open Home Page
    [Documentation]    options=add_argument("--disable-popup-blocking");add_argument("--disable-notifications");add_argument("--no-sandbox")
    ...    add_argument("--ignore-certificate-errors");
    Open Browser    ${HOMEPAGE URL}    ${BROWSER}    options=add_argument("--disable-popup-blocking");add_argument("--disable-notifications");add_argument("--no-sandbox");add_argument("--disable-logging");add_argument("--log-level=3")    executable_path=D:\\PythonAutomation\\PROJECT_BONG\\ChromeDriver_B2_B3\\chromedriver.exe
    Maximize Browser Window

Append Content To File
    [Arguments]    ${content}
    Append To File    ${path}${Rp_Prefix}    ${content}    encoding=UTF-8

Append Content Failed For TC
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Get And Set Location
    Comment    Run Keyword If    $sub_menu2 is not None    Append Content To File    ${menu} > ${sub_menu1} > ${sub_menu2}\n${location}\r\nFAILED : ${TEST_MESSAGE}\n------------------------------\n
    ...    ELSE IF    $sub_menu1 is not None    Append Content To File    ${menu} > ${sub_menu1}\n${location}\r\nFAILED : ${TEST_MESSAGE}\n------------------------------\n
    ...    ELSE    Append Content To File    ${menu}\n${location}\r\nFAILED : ${TEST_MESSAGE}\n------------------------------\n
    ${time}    Get Current Date    result_format=%H:00
    Set Global Variable    ${time}
    ${register_content}    Set Variable    ${time}    ${location}    ${menu} > ${sub_menu1}    FAILED : ${TEST_MESSAGE}\n------------------------------\n
    My Get Empty Row
    Open Excel Document    ${rpname}    Lotte
    Write Excel Row    ${rownum}    ${register_content}    sheet_name=${sheetname}
    Save Excel Document    ${rpname}
    Close All Excel Documents

Append Content Failed For KW
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Get And Set Location
    Run Keyword If    $sub_menu2 is not None    Append Content To File    ${menu} > ${sub_menu1} > ${sub_menu2}\n${location}\r\nFAILED : ${KEYWORD_MESSAGE}\n------------------------------\n
    ...    ELSE IF    $sub_menu1 is not None    Append Content To File    ${menu} > ${sub_menu1}\n${location}\r\nFAILED : ${KEYWORD_MESSAGE}\n------------------------------\n
    ...    ELSE    Append Content To File    ${menu}\n${location}\r\nFAILED : ${KEYWORD_MESSAGE}\n------------------------------\n

Append Content Passed
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Run Keyword If    $sub_menu2 is not None    Append Content To File    ${menu} > ${sub_menu1} > ${sub_menu2} => PASSED\n------------------------------\n
    ...    ELSE IF    $sub_menu1 is not None    Append Content To File    ${menu} > ${sub_menu1} => PASSED\n------------------------------\n
    ...    ELSE    Append Content To File    ${menu} => PASSED\n------------------------------\n

Run Keyword When End TC
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Run Keyword If    '${TEST_STATUS}' == 'PASS'    My Write Report If Test Pass    ${menu}    ${sub_menu1}
    Run Keyword If    '${TEST_STATUS}' == 'FAIL'    Append Content Failed For TC    ${menu}    ${sub_menu1}    ${sub_menu2}    #ELSE    Append Content Passed    ${menu}    ${sub_menu1}    ${sub_menu2}
    Close All Browsers

Run Keyword When A Step Failed For KW
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Comment    Run Keyword If    '${KEYWORD_STATUS}' == 'PASS'    My Write Report If Test Pass    ${menu}
    Run Keyword If    '${KEYWORD_STATUS}' == 'FAIL'    Append Content Failed For KW    ${menu}    ${sub_menu1}    ${sub_menu2}
    ...    ELSE    My Write Report If Test Pass    ${menu} > ${sub_menu1}
    Switch Window    MAIN

Run Keyword When End KW
    [Arguments]    ${menu}    ${sub_menu1}    ${sub_menu2}
    Run Keyword If    '${KEYWORD_STATUS}' == 'FAIL'    Append Content Failed For KW    ${menu}    ${sub_menu1}    ${sub_menu2}    #ELSE    Append Content Passed    ${menu}    ${sub_menu1}    ${sub_menu2}
    Switch Window    MAIN

Register Random Account
    Generate Random Email
    Input Register Data

Generate Random Email
    ${getemail}    Get Current Date    result_format=autoatl%d%H%M%S@yandex.com
    Convert To String    ${getemail}
    Set Global Variable    ${getemail}

Input Register Data
    Wait And Click Element    //nav[@class='container-header']//input[@class='btn btn-sign-up form-control']
    Wait And Input Text    //form[@id='frm-register-user']//input[@name='email']    ${getemail}
    Wait And Input Text    //form[@id='frm-register-user']//input[@name='password']    ${password}
    Wait And Input Text    //form[@id='frm-register-user']//input[@name='password_repeat']    ${password}
    Wait And Input Text    //form[@id='frm-register-user']//input[@name='phone']    ${phone}
    Wait And Click Element    //input[@value='Đăng ký']
    Alert Should Be Present    Bạn đã đăng ký thành công

Login With Valid Data
    Wait And Click Element    //nav[@class='container-header']//input[@class='btn btn-sign-in form-control']
    Wait And Input Text    //form[@class='form_login']//input[@name='email']    ${username}
    Wait And Input Text    //form[@class='form_login']//input[@name='password']    ${password}
    Wait And Click Element    //li[@style='padding-right:0;']/input[@value='Đăng nhập']
    Wait Until Page Contains Element    //div[@class='container-header']/descendant::div[@class='user-logined form_action']

Logout
    Execute Javascript    document.querySelector("#form_logined > div > div > ul > li:nth-child(7) > a").click();

Wait And Click Element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Click Element    ${locator}

Wait And Input Text
    [Arguments]    ${locator}    ${content}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${content}

Wait And Get Text
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    ${content}    Get Text    ${locator}
    Set Global Variable    ${content}

Get Time
    ${time}    Get Current Date    result_format=%b-%d-%Y %I:%M %p
    ${start_time}    Get Current Date
    Set Global Variable    ${time}
    Set Global Variable    ${start_time}

Get And Set Location
    ${location}    Get Location
    Set Global Variable    ${location}

Click Javascript
    [Arguments]    ${locator}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Check Lottery
    [Arguments]    ${locator}    ${element}
    ${content}    Get Text    ${locator}
    Wait And Click Element    ${locator}
    Wait Until Element Is Visible    ${element}
    Comment    Wait And Click Element    //nav[@class='container-header']//img[@alt='Logo']
    [Teardown]

Check Iframe
    [Arguments]    ${locator}    ${attribute}
    Wait And Click Element    ${locator}
    Wait Until Element Is Visible    ${attribute}
    Select Frame    ${attribute}

Go To Games Page
    Open Home Page
    Login With Valid Data
    Wait And Click Element    //div[@id='main-menu']//a[.='Trò chơi']

Check Feature Games
    Wait Until Element Is Visible    //*[@id="png-game-container"]
    Select Frame    //*[@id="png-game-container"]
    Sleep    1
    Wait Until Page Contains Element    //canvas
    Unselect Frame

Check Games
    [Arguments]    ${locator}    ${element}    ${sub_menu}    #${menu}
    Scroll Element Into View    ${locator}
    Wait And Get Text    ${locator}
    Wait Until Element Is Visible    ${element}
    Click Element    ${element}
    Switch Window    NEW
    Run Keyword If    '${sub_menu}' == 'Feature Games'    Check Feature Games
    ...    ELSE IF    '${sub_menu}' == 'Spribe'    Wait Until Element Is Visible    //app-game
    ...    ELSE    Wait Until Element Is Visible    //canvas
    Close Window
    Switch Window    MAIN
    Sleep    5s
    [Teardown]    #Run Keyword When A Step Failed For KW    ${menu}    ${sub_menu}    ${content}

Check Menu Games
    [Arguments]    ${menu}    ${locator}    ${start}    ${end}
    Sleep    0.5
    Wait And Click Element    ${locator}
    ${sub_menu}    Get Text    ${locator}
    FOR    ${x}    IN RANGE    ${start}    ${end}
        Run Keyword And Continue On Failure    Check Games    //*[@id="list-game-main"]/div[${x}]/div/div/h3    //div[@id='list-game-main']/div[${x}]//a[.='Chơi ngay']    ${sub_menu}
    END
    [Teardown]

Go To Casino Page
    Open Home Page
    Login With Valid Data
    Wait And Click Element    //li[8]/a[.='Sòng bài']

Get Request Location
    ${location}    Get Location
    ${resp}    Http Get    ${location}
    Status Should Be    ok    ${resp}

Check Casino
    [Arguments]    ${locator}    ${regions}
    ${content}    Get Text    //li[8]/a[.='Sòng bài']
    Wait And Click Element    ${regions}

Check N2 Casino
    [Arguments]    ${locator}    ${javascript}
    Wait Until Element Is Visible    ${locator}
    Execute Javascript    ${javascript}
    Sleep    2
    Switch Window    NEW
    Sleep    1
    Wait Until Element Is Visible    //canvas[@id='gameCanvas']
    Get Request Location
    Close Window
    Switch Window    MAIN
    [Teardown]    #Run Keyword When A Step Failed For KW    Casino    N2 Live    ${NULL}

Check Vivo Casino
    [Arguments]    ${locator}    ${javascript}    ${item}
    Wait Until Element Is Visible    ${locator}
    Execute Javascript    ${javascript}
    Sleep    2
    Switch Window    NEW
    Comment    Wait And Click Element    ${item}
    Comment    ${handle}    Switch Window    NEW
    Comment    Sleep    1
    Wait Until Location Contains    tables.kasoom
    Get Request Location
    Comment    Close Window
    Comment    Switch Window    ${handle}
    Close Window
    Switch Window    MAIN
    [Teardown]    #Run Keyword When A Step Failed For KW    Casino    Vivo    ${NULL}

Check Evo Casino
    [Arguments]    ${locator}    ${javascript}    ${item}
    Wait Until Element Is Visible    ${locator}
    Execute Javascript    ${javascript}
    Switch Window    NEW
    Wait Until Element Is Visible    ${item}
    Execute Javascript    document.getElementsByClassName('TableFlipbook--2L-lT')[0].click();
    Sleep    1
    Wait Until Element Is Visible    //video[1]
    Get Request Location
    Close Window
    Switch Window    MAIN
    [Teardown]    #Run Keyword When A Step Failed For KW    Casino    Evo    ${null}

Check Ebet Casino
    [Arguments]    ${locator}    ${javascript}
    Wait Until Element Is Visible    ${locator}
    Execute Javascript    ${javascript}
    Sleep    1
    Switch Window    NEW
    Wait Until Element Is Visible    //canvas
    Get Request Location
    Close Window
    Switch Window    MAIN
    [Teardown]    #Run Keyword When A Step Failed For KW    Casino    Ebet    ${Null}

Check Ezugi Casino
    [Arguments]    ${locator}    ${javascript}    ${item}
    Wait Until Element Is Visible    ${locator}
    Execute Javascript    ${javascript}
    Sleep    2
    Switch Window    NEW
    Wait Until Location Contains    http
    Run Keyword If    $item is not None    Wait Until Keyword Succeeds    10x    3s    Execute Javascript    ${item}
    Wait Until Element Is Visible    //*[@id="h5live-video-container" or @id="h5live-player_vid_hls" or @class='error_home_btn']
    Get Request Location
    Close Window
    Switch Window    MAIN
    [Teardown]    #Run Keyword When A Step Failed For KW    Casino    Ezugi    ${Null}

Check Event
    [Arguments]    ${locator}    ${attribute}    ${content}
    Wait And Click Element    ${locator}
    Wait Until Page Contains Element    ${attribute}
    [Teardown]    Run Keyword When A Step Failed For KW    ${content}

Check Sport News
    [Arguments]    ${locator}    ${attribute}    ${content}
    Scroll Element Into View    ${locator}
    Wait And Click Element    ${locator}
    Wait Until Element Is Visible    ${attribute}
    ${URL}    Get Element Attribute    ${attribute}    href
    ${resp}    Http Get    ${URL}
    Status Should Be    ok    ${resp}
    Comment    Wait And Click Element    //nav[@class='container-header']//img[@alt='Logo']
    [Teardown]    #Run Keyword When A Step Failed For KW    Trợ Giúp    ${content}    ${null}

Run Python
    Comment    ${cmd}    Set Variable    python ${EXECDIR}\\DATA\\check_response_lotte.py
    Comment    ${run}    Run Process    ${cmd}    shell=True
    Comment    Log    ${run.stdout}
    Run Process    python    ${cmd}

My Create New Final Report
    [Documentation]    ${rpname}
    ...    ${sheetname}
    ${month}    Get Current Date    result_format=%b
    ${sheetname}    Get Current Date    result_format=%d-%b
    ${rpname}    Set Variable    ${newpath}\\B2_Lotte_${month}_FPT.xlsx    #${path}\\B2_Lotte_${month}.xlsx
    Set Global Variable    ${rpname}
    Comment    ${sheetname}    Get Current Date    result_format=%M
    Set Global Variable    ${sheetname}
    ${status}    Run Keyword And Return Status    Open Workbook    ${rpname}
    Run Keyword If    '${status}' == 'False'    Create Workbook    ${rpname}
    Run Keyword And Return Status    Create Worksheet    ${sheetname}
    Save Workbook    ${rpname}
    Close Workbook
    My Get Empty Row
    Open Excel Document    ${rpname}    final
    Comment    Write Excel Cell    1    1    Check Alive    sheet_name=${sheetname}
    ${default_data}    Set Variable    Time    Domain    Functions    FPT
    Log    ${rownum}
    Run Keyword If    '${rownum}' == '2'    Write Excel Row    1    row_data=${default_data}    sheet_name=${sheetname}
    ...    ELSE    Write Excel Row    ${rownum}    row_data=${default_data}    sheet_name=${sheetname}
    Comment    Write Excel Row    ${rownum}    row_data=${default_data}    sheet_name=${sheetname}
    Save Excel Document    ${rpname}
    Close Current Excel Document

My Get Empty Row
    [Documentation]    ${rownum}
    Open Workbook    ${rpname}
    ${rownum}    Find Empty Row    name=${sheetname}
    Set Global Variable    ${rownum}
    Close Workbook

My Write To Final Report
    [Arguments]    ${raw_xlsx_name}
    My Get Empty Row
    Open Excel Document    ${raw_xlsx_name}    588
    Open Excel Document    ${rpname}    final
    FOR    ${i}    IN RANGE    0    3
        Switch Current Excel Document    588
        @{colAr}    Read Excel Row    ${i+3}
        Switch Current Excel Document    final
        Write Excel Row    ${rownum+${i}}    ${colAr}    sheet_name=${sheetname}
    END
    Save Excel Document    ${rpname}
    Close All Excel Documents

My Write Report If Test Pass
    [Arguments]    ${menu}    ${sub_menu1}
    ${time}    Get Current Date    result_format=%H:00
    Set Global Variable    ${time}
    Get And Set Location
    ${register_content}    Set Variable    ${time}    ${location}    ${menu} > ${sub_menu1}    PASSED
    My Get Empty Row
    Sleep    2
    Open Excel Document    ${rpname}    Lotte
    Write Excel Row    ${rownum}    row_data=${register_content}    sheet_name=${sheetname}
    Save Excel Document    ${rpname}
    Close All Excel Documents
