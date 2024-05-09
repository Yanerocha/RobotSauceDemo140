*** Settings ***
Library    SeleniumLibrary
Library    ../../.venv/Lib/site-packages/robot/libraries/XML.py

Test Teardown    Close Browser    # No final, fecha o navegador

*** Variables ***
${url}    https://www.saucedemo.com/
${browser}    Chrome

*** Test Cases ***
# frases --> Keywords
Selecionar Sauce Labs Backpack
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha    secret_sauce
    E clico no botao Login
    Entao sou direcionado para a pagina de produtos
    Quando clico no produto    Sauce Labs Backpack    $29.99
    Entao sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de items no carrinho    1
    Quando clico no icone do carrinho
    Entao sou direcionado para a pagina do carrinho

Selecionar Sauce Labs Backpack Login com Enter
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha    laranja
    E pressiono a tecla Enter
Selecionar Sauce Labs Backpack
    Dado que acesso o site Saucedemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha    secret_sauce
    E clico no botao Login

*** Keywords ***
Dado que acesso o site Saucedemo
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    10000ms
    Wait Until Element Is Visible    css=.login_logo    5000ms

Quando preencho o campo usuario
    [Arguments]    ${username}
    Input Text    css=[data-test="username"]    ${username}

E preenchoo campo senha
    [Arguments]    ${password}
    Input Password    css=[data-test="password"]    ${password}

E clico no botão Login
    Click Button    id=login-button

A pressiono a tecla Enter
    Press Key    css=[data-test="password"]    Enter

Entao sou direcionado para a pagina de produtos
    Element Text Should Be    css=.title    Products

Quando clico no produto
    [Arguments]    ${product_name}    ${product_price}
    Set Test Variable    ${test_product_name}    ${product_name}
    Set Test Variable    ${test_product_price}    ${product_price}
    Click Element    css=img[alt="${test_product_name}"]

Entao sou direcionado para a pagina do produto
    Element Text Should Be    name=back-to-Products    Back to Products
    Element Text Should Be    css=div.inventory_details_name.large_size    ${test_product_name}
    Element Text Should Be    css=div.inventory_details_price    ${test_product_price}

Quando clico em adicionar no carrinho
    Click Element    css=button.btn.btn_primary.btn_small.btn_inventory

Entao visualizo o numero de items no carrinho
    [Arguments]    ${cart_items}
    Set Test Variable    ${test_cart_items}
    Element Text Should Be    css=span.shopping_cart_badge    ${test_cart_items}

Quando clico no icone carrinho
    Click Link    ${test_cart_items}

Entao sou direcionado para a pagina do carrinho
    Wait Until Element Contains    css=.title    Your Cart
    Element Text Should Be    css=div.inventory_item_name    ${test_product_name}
    Element Text Should Be    css=div.inventory_item_price    ${test_product_price}
    Element Text Should Be    css=div.cart_quantity    ${test_cart_items}
