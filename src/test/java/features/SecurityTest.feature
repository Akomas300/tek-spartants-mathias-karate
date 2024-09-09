Feature: API testing for Security Functions

  Background:
    * url BASE_URL
    * path '/api/token'

  @US1
  Scenario: Valid token with valid credentials
    Given request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then print response
    Then status 200
    Then assert response.username == "supervisor"

  @US2
  Scenario Outline: Valid token with invalid username and valid password
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.errorMessage == "<errors>"
    Examples:
      | username    | password        | statusCode | errors                     |
      | supervisorX | tek_supervisor  | 404        | User supervisorX not found |
      | supervisor  | tek_supervisorX | 400        | Password not matched       |


  @PlanCode1
  Scenario: Testting endpoint /api/plans/get-all-plan-code
    #Given url BASE_URL
    #Given path "/api/token"
    Given request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then print response
    Then status 200
    * def token = response.token
    Given path "/api/plans/get-all-plan-code"
    Given header Authorization = "Bearer " + token
    When method get
    Then print response
    Then status 200
    Then assert response[0].planExpired == false
    Then assert response[1].planExpired == false
    Then assert response[2].planExpired == false
    Then assert response[3].planExpired == false





