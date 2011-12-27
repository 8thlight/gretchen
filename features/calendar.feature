Feature: As a craftsman
  I should see the 8th Light Google Calender
  on the Front Page of Gretchen

  @omniauth_test
Scenario: Can see 8th light calednar on Front Page
    Given I am a user with a valid 8th Light email account
    When I go to the root page
    And I click "Sign in with Google"
    When I go to the calendar page
    Then show me the page
    Then it should contain the "8th Light Time Off" google calendar

