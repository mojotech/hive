Feature: Login
  As a hive user, I should be required to login so that I have full access to
  the app.

  Scenario: User logs in
    When a hive user logs in
    Then the user should be logged in

  Scenario: User logs out
    When a hive user logs out
    Then the user should be logged out
