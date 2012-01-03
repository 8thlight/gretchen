Feature: As an admin
  I want to configure craftsmen and their vacation/personal days
  In order to track the use of vacations

@omniauth_test
  Scenario: Add a craftsman
    Given I am logged in as an admin
    When I go to the users page
    And I click "Create a New User"
    And I create a new craftsman with name, email, and number of vacation days
    Then it should persist in the database

@omniauth_test
  Scenario: Update a craftsman
    Given I am logged in as an admin
    And there are users to edit
    When I go to the users page
    When I click to edit a specific craftsman's vacation days
    And I update any name, email, and number of vacation days
    Then the edit should persist in the database

@omniauth_test
  Scenario: Delete a craftsman
    Given I am logged in as an admin
    And there are users to edit
    When I go to the users page
    When I click to delete a craftsman entry
    And I confirm the delete
    Then the craftsman and their vacation days should be logically deleted
    And the record should still persist in the database

@omniauth_test
  Scenario: User Vacation information display
    Given I am logged in as an admin
    And there are users to edit
    When I go to the calendar page
    Then it should display "Vacation Days Remaining"
    And it should display "Max Vacation Days"
    And it should display "Vacation Days Used"
