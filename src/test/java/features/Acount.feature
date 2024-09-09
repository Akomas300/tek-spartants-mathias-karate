Feature: Testing accounts
  @Account_1
  Scenario: Tesing /api/accouts/get-account
    Given url BASE_URL
    * def generateTokenResult = callonce read("GenerateSupervisorToken.feature")
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken
    * def accountId = 9479
    Given param primaryPersonId = accountId
    When method get
    Then status 200
    Then assert response.primaryPerson.id == accountId




  @Account_2
  Scenario: Tesing /api/accouts/get-account
    Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken
    * def accountId = 55225522
    Given param primaryPersonId = accountId
    When method get
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + accountId + " not found"


  @Activity
  Scenario: Testing /api/accounts/get-all-accounts
    Given url BASE_URL
    Given path "/api/accounts/get-all-accounts"
    When method get
    Then print response
    Then status 401

    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-all-accounts"
    Given header Authorization = validToken
    When method get
    Then print response
    Then status 200