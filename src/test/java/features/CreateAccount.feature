Feature: Create Acount feature
  @CreateAccount_1
  Scenario: Testting endpoint /api/accounts/add-primary-account
    Given url BASE_URL
    Given path "/api/accounts/add-primary-account"
    * def email = "akomas478@gmail.com"
    Given request
    """
    {
      "email": "#(email)",
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
    Then assert response.email == email
    * def createdAccountId = response.id
    * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
    * def validToken = "Bearer " + tokenGenerationResult.response.token
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = createdAccountId
    Given header Authorization = validToken
    When method delete
    Then status 202