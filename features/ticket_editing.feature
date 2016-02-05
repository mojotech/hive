Feature: Ticket Editing
  As a hive user, I should be able to update the content of a ticket description.

  Scenario: User edits a ticket description
    Given a ticket exists for a project
    When an authorized user edits the ticket description
    Then the user should see the ticket description has changed
