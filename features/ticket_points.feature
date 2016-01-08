Feature: Ticket Points
  As a hive user, I should be able to set the point value for a ticket to
  indicate how difficult it is.

  Scenario: User sets points of ticket
    When a hive user sets the point value of a ticket
    Then the user should see the ticket has the new point value
