
When /I go to the (\w+)/ do |path|
  if "#{path}" == "root"
    visit "/"
  else
    visit "/#{path}"
  end
end

And /I click "(.*?)"/ do |click|
  click_link "#{click}"
end


Given /I am a user with a gmail account/ do
  @user = User.new(:name => "Test User", :email => "test@not_8thlight.com", :vacationdays => 1)
  @user.save(:validate => false)
  OmniAuth.config.mock_auth[:google_oauth2] = {
    "provider"=>"google",
    "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
    "info"=>{"email"=>"test@not_8thlight.com", "first_name"=>"Test", "last_name"=>"User", "name"=>"Test User"}
  }
end

Given /I am a user with a valid 8th Light email account/ do
  @user = User.create!(:name => "Test User", :email => "test@8thlight.com", :vacationdays => 1)
  OmniAuth.config.mock_auth[:google_oauth2] = {
    "provider"=>"google",
    "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
    "info"=>{"email"=>"test@8thlight.com", "first_name"=>"Test", "last_name"=>"User", "name"=>"Test User"}

  }
end

Then /I should see "(.*?)"/ do |message|
  page.should have_xpath("//*", :text => message)
end

Then /I should be on the (\w+)/ do |path|
  current_path = URI.parse(current_url).path 
  current_path.should == "/#{path.downcase}"
end


