Given /I am a craftsman logged in as "([^"]*)"$/ do |name|
  visit "/"
  @user = User.create!(:name => "#{name}", :email => "user@8thlight.com", :vacationdays => 1)
    OmniAuth.config.mock_auth[:google_oauth2] = {
    "provider"=>"google",
    "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
    "info"=>{"email"=>"user@8thlight.com", "first_name"=>"#{name}", "last_name"=>"", "name"=>"#{name}"},
    "credentials"=>{"token"=>"token"}
  }
  click_link "Sign in with Google"
end

Then /^the vacation entry on the date "11\/11\/2012" for "John Lennon vacation" is persisted.$/ do
  user = User.find_by_name("John Lennon")
  user.vacations.last.start_date.strftime("%m/%d/%Y").should == '11/11/2012'
end

When /^I enter in a vacation day at "([^"]*)" for "([^"]*)"$/ do |date, user|
  fill_in('Start date', :with => date)
  fill_in('End date', :with => date)
  click_button('Submit')
end

Then /^the date "([^"]*)" should be a vacation of "([^"]*)"$/ do |date, who|
 vacation = Vacation.last
 user = User.find_by_name(who)
 vacation['user_id'].should == user.id
end
