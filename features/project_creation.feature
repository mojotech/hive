Feature: App Creation
  As a hive user, I should be able to add an app for a github repository.

  Scenario: User creates an app
    When a hive user creates an app with a github repository
    Then the user should see the app they created
