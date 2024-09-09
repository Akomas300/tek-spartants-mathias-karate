Feature: Generate supervisor token
  Scenario: Generate a valid token
    Given url BASE_URL
    Given path "/api/token"
    Given request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then print response
    Then status 200