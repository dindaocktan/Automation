Resource                           ../PageImporter.robot

*** Variable ***

*** Keywords ***
###################### GETTER ##########################
Iridescent List Length
    ${length}                                Execute Javascript                                                return $('${ARTICLE_IRIDESCENT_LIST}').length
    [Return]                                 ${length}

Multiple Page Length
    ${length}                                Execute Javascript                                                return $('${MULTIPLE_PAGE_ARTICLE}').length
    [Return]                                 ${length}

TextType Article Length
    ${rowarticle}                            Execute Javascript                                                return $('${ARTICLE_TEXT_ITEM_TITLE}').length
    [Return]                                 ${rowarticle}

Get Href Without Parameter
    [Arguments]                              ${headline_href}
    #${headline_href}=                           Execute Javascript                                    return window.location.href;
    ${article_href_new_format}=              Fetch From Left                                                   ${headline_href}                                                          ?
    [Return]                                 ${article_href_new_format}


###################### OPEN BROWSER ##########################
VirtualDisplay
    Start Virtual Display                    2560                                                              1440

Open Browser With Timeout
    [Timeout]                                120 Second
    Open Browser                             ${HOME URL}?google_nofetch=1                                      ${BROWSER}
    Keywords.All Ads Closer
    Sleep                                    5
    Keywords.Push Notif Closer

Open Browser To Login Page
    [Timeout]                                300 Second
    Open Browser                             ${LOGIN URL}                                                      ${BROWSER}
    #Execute Javascript                       window.stop()
    Sleep                                    5
    Keywords.Push Notif Closer


Open Browser With Blank URL
    [Timeout]                                120 Second
    Open Browser                             about:blank                                                       ${BROWSER}
    Sleep                                    5
    Keywords.Push Notif Closer


###################### WINDOW SCROLL ##########################
Scroll To Element
    [Arguments]                              ${element}
    Wait Until Page Contains Element         ${element}                                                        timeout=3                                                                 error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    Execute Javascript                       window.scrollTo(0,${ver}-90)
    Sleep                                    1

Scroll To Top Page
    Execute Javascript                       window.scrollTo(0, 0);

Scroll To Bottom Page
    Execute Javascript                       window.scrollTo(0, document.body.scrollHeight);
    Sleep                                    2

Scroll Until Element Is Clickable
    [Arguments]                              ${element}
    Wait Until Element Is Visible            ${element}                                                        timeout=10                                                                error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    ${dec}=                                  Evaluate                                                          50
    Keywords.Scroll To Top Page
    :FOR  ${i}  IN RANGE  100
    \    Execute Javascript                  window.scrollTo(0,${ver}-${dec})
    \    ${status}                           ${value}=                                                         Run Keyword And Ignore Error                                              Click Link                                                         ${element}
    \    Run Keyword If                      '${status}' == 'PASS'                                             Exit For Loop
    \    ${dec}=                             Evaluate                                                          ${dec}+50


Scroll To Element With Parameters
    [Arguments]                              ${element}                                                        ${vertical}
    Wait Until Page Contains Element         ${element}                                                        timeout=3                                                                 error=There's no ${element}
    ${ver}=                                  Get Vertical Position                                             ${element}
    Execute Javascript                       window.scrollTo(0,${ver}-${vertical})
    Sleep                                    2

###################### LOGIN AS & LOGOUT ##########################
Login
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          ${VALID USER}
    Input Password                           password                                                          ${VALID PASSWORD}
    Click Button                             Masuk
    Page Should Contain Element              sizzle=${USER_AVATAR}
    Keywords.Verify Page After Login

Click Social Media Login Button
    [Arguments]                              ${social_media_type}
    Click Element                            sizzle=${SOSMED_LOGIN_BUTTON}:contains("${social_media_type}")
    Sleep                                    1
    Run Keyword If                           '${social_media_type}'=='Facebook'                                Location Should Contain                                                   web.facebook.com
    ...                                      ELSE IF                                                           '${social_media_type}'=='Google'                                          Location Should Contain                                            https://accounts.google.com/

Input Facebook Login Attribute
    Input Text                               email                                                             ${EMAIL_FACEBOOK}
    Input Text                               pass                                                              ${PASSWORD_FACEBOOK}

Click Facebook Login Button
    ${check}                                 ${value} =                                                        Run Keyword And Ignore Error                                              Click Button                                                       Login
    Run Keyword If                           '${check}' == 'FAIL'                                              Click Button                                                              Login

Click Facebook Ya
    ${check}                                 ${value} =                                                        Run Keyword And Ignore Error                                              Click Button                                                       Ya

Input And Submit Google+ Login Attribute
    Wait Until Element Is Visible            id=${IDENTIFIER_ID}
    Input Text                               id=${IDENTIFIER_ID}                                               ${EMAIL_GOOGLE}
    Sleep                                    3
    Click Element                            id=${IDENTIFIER_NEXT}
    Sleep                                    3
    ${current_location}=                     Get Location
    Input Text                               dom=${GOOGLE_PASSWORD_FIELD}                                      ${PASSWORD_GOOGLE}
    Sleep                                    3
    Click Element                            id=${GOOGLE_PASSWORD_NEXT_BUTTON}
    Sleep                                    3

Verify Page After Login
    Sleep                                    1
    Page Should Not Contain Element          sizzle=${LOGIN_LINK_MENU}
    Wait Until Element Is Visible            sizzle=${USER_AVATAR}                                             timeout=15

Login with Editor
    Sleep                                    1
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          qaedit
    Input Password                           password                                                          Senayan14
    Click Button                             Masuk
    sleep                                    1

Go To Login Page
    Click Element                            sizzle=\#login
    Location Should Contain                  /login
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}                                    timeout=15

Login with Admin
    Keywords.Go To Login Page
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          ${VALID USER}
    Input Password                           password                                                          ${VALID PASSWORD}
    Click Button                             Masuk
    Click Link                               sizzle=${DROPDOWN_USER}

Login with Tag Manager
    Sleep                                    1
    Wait Until Element Is Visible            sizzle=${AUTHENTICATION_LOGIN}
    Input Text                               username                                                          qagtm
    Input Password                           password                                                          Senayan14
    Click Button                             Masuk
    sleep                                    1

Logout
    Sleep                                    0.5
    Keywords.Click User Menu                 Keluar
    Keywords.Verify Page After Logout

Verify Page After Logout
    Page Should Not Contain Element          sizzle=${USER_AVATAR}
    Wait Until Element Is Visible            sizzle=${LOGIN}                                                   timeout=15
    Location Should Be                       ${HOME URL}

