Feature: Acceptance Criteria
  As a hive user, I should be able to add an acceptance criteria to a ticket to
  specify what must be done to satisfy the ticket.

  Scenario: User adds an acceptance criterion
    When a user adds an acceptance criterion to a ticket
    Then the user should see the ticket has a new acceptance criterion
