*** Settings ***
Suite Setup       Create File And Get Times
Suite Teardown    Count Times And Close
Resource          ../GLOBAL/Pages.robot

*** Test Cases ***
TC01_Register
    [Setup]    #Open Home Page
    Comment    Register Random Account
    [Teardown]    #Run Keyword When End TC    Register    ${null}    ${null}

TC02_Login
    [Setup]    Open Home Page
    Login With Valid Data
    Logout
    [Teardown]    Run Keyword When End TC    Login    ${null}    ${null}

TC03_Lottery
    [Documentation]    Lô Đề 3 Miền
    [Setup]    Go To Home Page
    FOR    ${x}    IN RANGE    1    4
        Run Keyword And Continue On Failure    Check Lottery    //div[@id='main-menu']/div[2]/div/ul/li[${x}]/a    //div[@class='kd1 act']
    END
    [Teardown]    Run Keyword When End TC    Lô Đề 3 Miền    ${null}    ${null}

TC04_LoDeSieuToc
    [Setup]    Go To Home Page
    Check Iframe    //a[contains(.,'Lô đề siêu tốc')]    //*[@id="iframe"]
    Wait Until Element Is Visible    //a[.='Lô 2 số']
    Unselect Frame
    [Teardown]    Run Keyword When End TC    Lô Đề Siêu Tốc    ${null}    ${null}

TC05_Quay_So
    [Setup]    Go To Home Page
    Check Iframe    //div[@id='main-menu']//a[contains(.,'Quay số')]    //*[@id="page-content"]/div[2]/iframe
    Wait Until Element Is Visible    //div[.='Bầu Cua']
    Unselect Frame
    [Teardown]    Run Keyword When End TC    Quay So    ${null}    ${null}

TC06a_Feature_Games
    [Setup]    Go To Games Page
    [Template]    Check Menu Games
    Feature Games    //span[.='Feature Games']    2    6
    [Teardown]    Run Keyword When End TC    Feature Games    ${null}    ${null}

TC06b_Table_Games
    [Setup]    Go To Games Page
    [Template]    Check Menu Games
    Table Games    //span[.='Table Games']    2    6
    [Teardown]    Run Keyword When End TC    Table Games    ${null}    ${null}

TC06c_Spribe
    Comment    [Setup]    Go To Games Page
    Comment    [Template]    Check Menu Games
    Comment    Spribe    //span[.='Spribe']    2    6
    Comment    [Teardown]    Run Keyword When End TC    Spribe    ${null}    ${null}

TC06d_Bắn_Cá
    Comment    [Setup]    Go To Games Page
    Comment    [Template]    Check Menu Games
    Comment    Bắn Cá    //span[.='Bắn cá']    3    4
    Comment    [Teardown]    Run Keyword When End TC    Bắn Cá    ${null}    ${null}

TC07_Nổ_Hũ
    [Setup]    #Go To Games Page
    Comment    Sleep    0.5
    Comment    Wait And Click Element    css=#navbarSupportedContent > ul > li:nth-child(7) > a
    Comment    Wait And Click Element    //span[.='Slots']
    Comment    ${sub_menu}    Get Text    //span[.='Slots']
    Comment    FOR    ${x}    IN RANGE    2    22
    Comment    \    Run Keyword And Continue On Failure    Check Games    //*[@id="list-game-main"]/div[${x}]/div/div/h3    //div[@id='list-game-main']/div[${x}]//a[.='Chơi ngay']    ${sub_menu}
    Comment    END
    Comment    Page Should Contain Element    //*[@id="list-game-main"]/div/div/div[2]    limit=20
    [Teardown]    #Run Keyword When End TC    Nổ Hũ    ${null}    ${null}

TC08_N2_Casino
    [Setup]    Go To Casino Page
    FOR    ${x}    IN RANGE    0    5
        Run Keyword And Continue On Failure    Check N2 Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();
    END
    [Teardown]    Run Keywords    Run Keyword When End TC    Casino    N2 Live    ${null}
    ...    AND    Close All Browsers    #Run Keyword When End TC | Casino | N2 Live | ${null}

TC09_Vivo_Casino
    [Setup]    Go To Casino Page
    Wait Until Location Contains    http
    Execute Javascript    window.scrollTo(0,300);
    FOR    ${x}    IN RANGE    5    9
        Run Keyword And Continue On Failure    Check Vivo Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();    //div[@id='container']/div[1]/div[7]//li[1]/span
    END
    [Teardown]    Run Keywords    Run Keyword When End TC    Casino    Vivo    ${null}
    ...    AND    Close All Browsers    #Run Keyword When End TC | Casino | Vivo | ${null}

TC010_Evo_Casino
    [Setup]    #Go To Casino Page
    Comment    Wait Until Location Contains    http
    Comment    Execute Javascript    window.scrollTo(0,600);
    Comment    FOR    ${x}    IN RANGE    9    16
    Comment    \    Run Keyword And Continue On Failure    Check Evo Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();    //div[@class='wrap-inner ListLobbyTablesInner--1tJuR']/div[1]//img[1]
    Comment    END
    [Teardown]    #Run Keywords    Run Keyword When End TC    Casino    Evo    ${null}    # AND    Close All Browsers

TC011_Ebet_Casino
    [Setup]    #Go To Casino Page
    Comment    Wait Until Location Contains    http
    Comment    Execute Javascript    window.scrollTo(0,900);
    Comment    FOR    ${x}    IN RANGE    16    21
    Comment    \    Run Keyword And Continue On Failure    Check Ebet Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();
    Comment    END
    [Teardown]    #Run Keywords    Run Keyword When End TC    Casino    Ebet    ${null}    # AND    Close All Browsers

TC012_Ezugi_Casino
    Comment    [Setup]    Go To Casino Page
    Comment    Wait Until Location Contains    http
    Comment    Execute Javascript    window.scrollTo(0,1400);
    Comment    FOR    ${x}    IN RANGE    21    29
    Comment    Run Keyword And Continue On Failure    Run Keyword If    '${x}' == '25' or '${x}' == '27'    Check Ezugi Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();    ${null}
    Comment    ...
    ...    ELSE    Check Ezugi Casino    //div[@id='list-casino-main']/div[${x+1}]//p[@class='meal-info-link']    document.getElementsByClassName('btn btn-yellow')[${x}].click();    document.getElementsByClassName('table__table_image___1eeWa')[0].click();
    Comment    END
    Comment    #TC018_Event
    Comment    #    [Setup]    Go To Home Page
    Comment    #    Check Event    //li[12]/a[.='Sự kiện']    //*[@id="top-win"]    Event
    Comment    #    Wait And Click Element    //nav[@class='container-header']//img[@alt='Logo']
    Comment    #    [Teardown]    Run Keyword When A Step Failed For TC    Event    22    30
    Comment    [Teardown]    Run Keywords    Run Keyword When End TC    Casino    Ezugi    ${null}
    Comment    ...
    ...    AND    Close All Browsers    #Run Keyword When End TC | Casino | Ezugi | ${null}

TC013_Keno_Vietlott
    [Setup]    Go To Home Page
    Check Iframe    //a[.='Keno Vietlott']    //*[@id="iframe"]
    Wait Until Element Is Visible    //div[@class='row justify-content-end']//a[.='Bảng cược']
    Unselect Frame
    [Teardown]    Run Keyword When End TC    Keno Vietlott    ${null}    ${null}

TC014_Keno_24/7
    [Setup]    Go To Home Page
    Check Iframe    //a[.='Keno 24/7']    //*[@id="iframeKeno"]
    Wait Until Element Is Visible    //label[.='Tiêu chuẩn']
    Unselect Frame
    [Teardown]    Run Keyword When End TC    Keno 24/7    ${null}    ${null}

TC015_Numbergame
    [Setup]    Go To Home Page
    Check Iframe    //li[11]/a[.='Numbergame']    //*[@id="iframeKeno"]
    Wait Until Element Is Visible    //span[.='Lịch sử cược']
    Unselect Frame
    [Teardown]    Run Keyword When End TC    Numbergame    ${null}    ${null}

TC016_Sport_News
    [Setup]    Go To Home Page
    [Template]    Check Sport News
    //a[.='Soi cầu lô đề']    css=#div_trogiup_detail > div:nth-child(1) > div.col-xs-8 > h2 > a    Soi cầu
    //div[@class='footer-bottom containers-custom']//a[.='Giải mã giấc mơ']    css=#div_trogiup_detail > div:nth-child(1) > div.col-xs-8 > h2 > a    Giải mã giấc mơ
    //a[.='Kinh nghiệm đánh lô đề, số đề']    css=#div_trogiup_detail > div:nth-child(1) > div.col-xs-8 > h2 > a    Kinh nghiệm đánh đề
    [Teardown]    Run Keyword When End TC    Sport New    ${null}    ${null}
