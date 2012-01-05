Feature: As an admin of the vacation system
In order to see a snapshot of the people on vacation
I want to have vacation days synch with the 8th Light google calendar

@omniauth_test
  Scenario: Export to vacation date to Google
    Given I am a craftsman logged in as "John Lennon"
    And I click "Vacation Time"
    When I enter in a vacation day at "11/11/2012" for "John Lennon"
    And I go to the calendar
    Then the date "11/11/2012" should be a vacation of "John Lennon"

