Feature: Create Account and delete it with defferent users
  @CreateAccount
  Scenario Outline: Testing /api/accounts/add-primary-account
    Given url BASE_URL
    * def emailGenerator = Java.type("data.GenerateRandomEmail")
    * def randomEmail = emailGenerator.randomEmail()
    Given path "/api/token"
    Given request {"username": "<username>","password": "<password>"}
    When method post
    Then status 200
    * def token = response.token
    Given path "/api/accounts/add-primary-account"
    Given request
      """
      {
        "email": "#(randomEmail)",
        "firstName": "Mathias",
        "lastName": "Akowanou",
        "title": "Mr.",
        "gender": "Male",
        "maritalStatus": "Single",
        "employmentStatus": "Tester",
        "dateOfBirth": "1922-12-12"
      }
      """
    When method post
    Then print response
    * def userID = response.id
    Then status 201

    Given path "/api/accounts/delete-account"
    * def validToken = "Bearer " + token
    Given param primaryPersonId = userID
    Given header Authorization = validToken
    When method delete
    Then status <status>
    Examples:
      | username          | password       | status |
      | supervisor        | tek_supervisor | 202    |
      | operator_readonly | Tek4u2024      | 403    |


