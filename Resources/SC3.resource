*** Settings ***
Library     SeleniumLibrary




*** Variables ***

${browser}  chrome
${url}  https://test.salesforce.com/
${un}   testuser@gmail.com.jnprtest
${pwd}  Juniper$9531
${JURL}    https://supportportal-test.juniper.net/
${JUN}    corneliuscustomer@gmail.com
${JPWD}    Juniper$1000
${validcontactame}   CORNELIUS CUSTOMER
#${validSLA2contactname}   DELIA DO NOT DENY
${SC3Accountname}   MILKY WAY MODULES EMEA
#${AccountnameSLA2}   MILKY WAY MODULES USA
#${SerialNo}    PD3715380229
${SC3SerialNo}    JN127091CRFB
${version}    23.4
${release}    R1
${DROPDOWN_LOCATOR}    xpath://span[@class='slds-media__body']/span[@title='23.4']
${Case_Number}    None
${showmore}    xpath:(//button[text()='Show More'])[1]
${JATACun}    testmanager@gmail.com.jnprtest
${JATACpwd}    JuniperJTAC$1234
${locator}    css=[title="Edit Total loss Element Mngt System (EMS)"]
*** Keywords ***
loginToApplication
    SeleniumLibrary.Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Input Text    xpath://input[@id='username']    ${un}
    Input Password    xpath://input[@id='password']    ${pwd}
    Click Button    xpath://input[@id='Login']
    Sleep    5

loginasJTACmanager
    # SeleniumLibrary.Open Browser    ${url}    ${browser}
    # Maximize Browser Window
    Input Text    xpath://input[@id='username']    ${JATACun}
    Input Password    xpath://input[@id='password']    ${JATACpwd}
    Click Button    xpath://input[@id='Login']
    Sleep    5    

LoginasJSPuser
    Sleep    5
    Click Element    xpath://button[@aria-label='Search']
    Sleep        5
    Input Text    xpath://input[@type='search' and @placeholder= 'Search...']    ${validcontactame}
    #Input Text    xpath:(//div[@type='search']/input[@type='search'])[2]    ${validcontactame}
    Wait Until Element Is Visible    xpath://span[@title='${validcontactame}']    20
    Click Element    xpath://span[@title='${validcontactame}']
    Sleep        10
    #Click Button    xpath://li[@class='slds-dropdown-trigger slds-dropdown-trigger_click slds-button_last overflow']//button[@type='button']
    #Wait Until Element Is Visible    xpath:(//button[normalize-space(.)='Show more actions'])[2]   20
    Click Button    xpath:(//button[@class='slds-button slds-button_icon-border-filled fix-slds-button_icon-border-filled slds-button_last']/span[text()='Show more actions'])[2]
    Click Link    xpath://a[normalize-space(.)='Log in to Experience as User']
    Sleep    10
    Click Link    xpath://a[normalize-space(.)='Juniper Support Portal']
    Sleep    10

LoginthroughtheJSP
    Open Browser    ${JURL}    ${browser}
    Maximize Browser Window
    Click Button    //div[@class='msgSection slds-p-around_medium']/button[normalize-space(.)='Log in']
    Wait Until Element Is Visible    locator=//input[@name='identifier']    timeout=30
    Input Text    locator=//input[@name='identifier']    text=${JUN}
    Click Button    //button[normalize-space(.)='Next']
    Sleep    5
    Click Button    //button[@aria-label='Select Password.']
    Sleep    5
    Input Password    locator=//input[@name='credentials.passcode']   password=${JPWD}
    Click Button    locator=//button[normalize-space(.)='Verify']
    Sleep    5

CreateaCase
    Wait Until Element Is Visible      //a[normalize-space(.)='Cases']    20
    Click Link    xpath://a[normalize-space(.)='Cases']
    #Sleep    10
    Wait Until Element Is Visible    //button[@class='slds-button slds-button_outline-brand slds-button jnpr-button_neutral' and text()='Create Case']    20
    Click Button    xpath://button[@class='slds-button slds-button_outline-brand slds-button jnpr-button_neutral' and text()='Create Case']
    Wait Until Element Is Visible    xpath://label//p[text()='Support and RMA requests for products with Juniper support contracts.']    20
    Click Element    xpath://label//p[text()='Support and RMA requests for products with Juniper support contracts.']
    Click Button    xpath://button[text()='Next']
    Sleep    5
    Wait Until Element Is Visible    xpath://div[label[text()='Account Name']]//input    20
    Click Element    xpath://div[label[text()='Account Name']]//input
    Input Text    xpath://div[label[text()='Account Name']]//input    ${SC3Accountname}
    Sleep    3 
    Click Element    xpath://li[@title='${SC3Accountname}']
    Sleep    5
    Click Button    xpath://button[@name='Priority']
    Sleep    3
    Click Element   xpath://lightning-base-combobox-item[@data-value='P2 - High']//span[text()='P2 - High']
    Click Button    xpath://button[@aria-label='Initial follow-up method']
    Click Element   xpath://span[text()='Case Update']
    Input Text    xpath://div/textarea[@name='Summary']    JNPR  Automation POC
    Input Text    //div/textarea[@name='Description']    JNPR Automation description
    Execute Javascript      window.scrollTo(0,5000)
    Click Button    xpath://button[text()='Next']
    Input Text    xpath://div[label[text()='Serial #/Software Support Reference #']]//input    text=${SC3SerialNo} 
    Click Button    locator=//button[text()='Validate']
    Sleep    10
    Click Button    //button[@name='version']
    Execute JavaScript  
    ...    var option = document.evaluate("//span[@class='slds-media__body']/span[@title='${version}']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    if (option) option.scrollIntoView({behavior: 'smooth', block: 'center'});

    Sleep    1s     
    Click Element    //span[@class='slds-media__body']/span[@title='${version}'] 
    Sleep    5
    Click Button    //button[@name='release']
    Click Element    //span[text()='${release}']
    Sleep    5
    Input Text        xpath://input[@name='routerName']    JNPRTEST Automation Test demo_Prasanna
    Input Text        xpath://input[@name='custTrackingNumber']    JNPRTEST abc123_Prasanna
    Execute Javascript      window.scrollTo(0,5000) 
    Click Button    xpath://button[text()='No']
    Sleep    5   
    Click Button    xpath://button[text()='Finish']
    Wait Until Element Is Visible    //span[text()='Summary']    30
    ${Case_Number}=    Get Text    //p[text()='Case Number']/following::lightning-formatted-text[1]
    Set Suite Variable    ${Case_Number}

Opencaseandverifydetails
    Sleep    5
    Wait Until Element Is Visible    //button[@aria-label='Search']    20
    Click Button    //button[@aria-label='Search']
    Sleep    5
    Click Element    //input[@placeholder='Search...']
    Input Text    //input[@placeholder='Search...']    ${Case_Number} 
    Sleep    5
    Click Element    //div[@class='slds-text-link--reset slds-grid slds-grid--vertical-align-center slds-truncate instant-result-item slds-p-left_small two-fields instant-result-item-record-suggestion']
    #Wait Until Element Is Visible    //div[@class='slds-form-element slds-hint-parent test-id__output-root slds-form-element_readonly is-stacked is-stacked-not-editing']/dt/div[@class='test-id__field-label-container slds-form-element__label no-utility-icon']/span[text()='Case Number']/../../following-sibling::dd/div/span    20
    Sleep    20
    Capture Page Screenshot    SC3casedetails.png
    Wait Until Element Is Visible    xpath:(//a[contains(@class, 'slds-tabs_default__link') and @data-tab-value='detailTab'])[last()]    20
    Click Link    xpath:(//a[contains(@class, 'slds-tabs_default__link') and @data-tab-value='detailTab'])[last()]
    Sleep    15
    Scroll Element Into View    xpath=//span[@class='slds-truncate' and @title='Routing Details']
    Capture Page Screenshot    SC3routing.png
    Sleep    5
    Scroll Element Into View    Xpath=//span[@class='slds-truncate' and @title='SLA Information']
    Sleep    5
    Capture Page Screenshot    SC3routing1.png
    Sleep    5
    Scroll Element Into View    xpath=//span[@class='slds-truncate' and @title='Category and Cause']
    Sleep    5
    Capture Page Screenshot    SC3Productinfo.png
    #Scroll Element Into View    xpath=//span[text()='Milestones']
    Sleep    2
    ${element_present}=    Run Keyword And Return Status    Element Should Be Visible    ${showmore}    10
    Run Keyword If    ${element_present}    Click Element    ${showmore}
    capture page screenshot    SC3showmore.png
    Run Keyword If    not ${element_present}    Log    Element not present   
    Capture Page Screenshot    SC3showmorenot.png
    Sleep    2