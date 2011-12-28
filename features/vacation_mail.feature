Feature: Whenever a vacation time is created
  There should be information about it
  sent through e-mail

  @omniauth_test
  Scenario: And e-mail is sent to the User
    Given I am a craftsman logged in as "John Lennon"
    And I click "Vacation Time"
    And I fill in "Start date" with "11/11/2012"
    And I fill in "End date" with "13/11/2012"
    And I press "Submit"
    Then I should recieve an e-mail confirmation

  @omniauth_test
  Scenario: A reminder e-mail is sent to the User
    Given I am a craftsman named "John Lennon"
    And I have a vacation that starts in 7 days
    Then I should recieve an e-mail reminder

