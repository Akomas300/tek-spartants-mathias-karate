Feature: Testing the user profile
  @profile
  Scenario: Testing /api/user/profile
  Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given header Authorization = validToken
    Given path "/api/user/profile"
    When method get
    Then print response
    Then status 200
    Given path "/api/user/profile"
    * def generateTokenResult = callonce read('GenerateOperatorReadOnlyToken.feature')
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then print response
    Then status 200

