Feature: End to end testing
  @End2End
  Scenario: Testting endpoint /api/accounts/add-primary-account
    Given url BASE_URL
    Given path "/api/accounts/add-primary-account"
    * def randomEmail = Java.type("data.GenerateRandomEmail").randomEmail()
   # * def randomEmail = emailGenerator.randomEmail()
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
        "dateOfBirth": "1952-09-11"
      }
      """
    When method post
    Then print response
    Then status 201
    * def accountId = response.id
    * def tokenGenerator = callonce read('GenerateSupervisorToken.feature')
    * def token = "Bearer " + tokenGenerator.response.token
    Given path "/api/accounts/get-account"
    Given param primaryPersonId = accountId
    Given header Authorization = token
    When method get
    Then print response
    Then status 200
    Then assert response.primaryPerson.email == randomEmail
    Then assert response.primaryPerson.firstName == "Mathias"
    Then assert response.primaryPerson.gender == "MALE"

    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = accountId
    Given header Authorization = token
    When method delete
    Then status 202

    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = accountId
    Given header Authorization = token
    When method delete
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + accountId + " not exist"