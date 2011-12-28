Feature: Whenever a vacation time is created
  There should be information about it
  sent through e-mail

  @omniauth_test
  Scenario: And e-mail is sent to the User
    Given I am a craftsman logged in as "John Lennon"
    And I click "Choose Vacation Period"
    And I fill in "Start date" with "11/11/2012"
    And I fill in "End date" with "13/11/2012"
    And I press "Submit"
    Then I should recieve e-mail confirmation

  @omniauth_test
  Scenario: A reminder e-mail is sent to the User

