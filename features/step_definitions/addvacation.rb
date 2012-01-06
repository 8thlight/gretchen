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

Then /^the vacation entry on the date "([^"]*)" for "([^"]*)" is persisted.$/ do |date, user|
  user = User.find_by_name("#{user}")
  user.vacations.last.start_date.strftime("%m/%d/%Y").should == "#{date}"
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

And /^I click delete for the vacation period starting on "([^"]*)"$/ do |date|
  vacation = Vacation.find_by_start_date("#{date}")
  find_button("#{vacation.start_date}").click
end

And /^I click delete on that vacation period$/ do
  @vacation = @user.vacations.last
  find_button("#{@vacation.start_date}").click
end

And /^I fill in "Start date" and "End date" with earlier dates$/ do
  fill_in('Start date', :with => "#{1.day.ago.to_date.strftime("%d/%m/%Y")}")
  fill_in('End date', :with => "#{(Time.now + 3).to_date.strftime("%d/%m/%Y")}")
  click_button('Submit')
end

Then /^the vacation period should still exist$/ do
  page.should have_content("#{@vacation.start_date.strftime("%m-%d-%Y")} #{@vacation.end_date.strftime("%m-%d-%Y")}")
end

