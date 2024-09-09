Feature: Generate Operator read only token
  Scenario: Generate a valid token
    Given url BASE_URL
    Given path "/api/token"
    Given request {"username": "operator_readonly","password": "Tek4u2024"}
    When method post
    Then print response
    Then status 200