Feature: As an 8th Light Craftsman
I want to access the vacation application
To be able to set my time off

@omniauth_test
Scenario: 8th Lighter can log in
Given I am a user with a valid 8th Light email account
When I go to the root page
And I click "Sign in with Google"
Then I should be on the calendar page

@omniauth_test
Scenario: non-8thlighter
Given I am a user with a gmail account
When I go to the root page
And I click "Sign in with Google"
Then I should see "You must be an 8th Light Craftsman to see this project"

Scenario: Routing Authentication
Given I am a user with a valid 8th Light email account
When I go to the calendar page
Then I should see "You must log in to see this page"
And I should see "Sign in with Google"
