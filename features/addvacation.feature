Feature: As a craftsman
In order to plan for my vacation
I want to enter a vacation I am taking in advance

@omniauth_test
Scenario: I want to enter a vacation day
    Given I am a craftsman logged in as "John Lennon"
    And I click "Choose Vacation Period"
    When I fill in "Start date" with "11/11/2012"
    And I fill in "End date" with "11/11/2012"
    When I press "Submit"
    Then the vacation entry on the date "11/11/2012" for "John Lennon vacation" is persisted.