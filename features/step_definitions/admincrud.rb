Given /I am logged in as an admin/ do
  visit "/"
  @admin = User.create!(:name => "admin", :email => "admin@8thlight.com", :vacationdays => 1)
    @admin.toggle!(:admin)
    @admin.admin?.should == true
    OmniAuth.config.mock_auth[:google_oauth2] = {
    "provider"=>"google",
    "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
    "info"=>{"email"=>"admin@8thlight.com", "first_name"=>"admin", "last_name"=>"", "name"=>"admin"},
    "credentials"=>{"token"=>"tookkeeeennnnn"}

  }
  click_link "Sign in with Google"
end

And /I create a new craftsman with name, email, and number of vacation days/ do
  fill_in("Name", :with => "bob")
  fill_in("Email", :with => "bob@8thlight.com")
  fill_in("Vacationdays", :with => "20")
  click_button("Create")
end

And /there are users to edit/ do
  @user1 = User.create!(:name => "bob", :email => "bob@8thlight.com", :vacationdays => 1)
  @user2 = User.create!(:name => "george", :email => "georde@8thlight.com", :vacationdays => 5)
  @user3 = User.create!(:name => "jill", :email => "jill@8thlight.com", :vacationdays => 6)
end

When /I click to edit a specific craftsman's vacation days/ do
  visit "/users/#{@user1.id}/edit"
end


And /I update any name, email, and number of vacation days/ do
  fill_in("Vacationdays", :with =>"20")
  click_button("Update")
end

Then /^it should persist in the database$/ do
  User.find_by_name('bob').name == 'bob'
end

Then /^the edit should persist in the database$/ do
  user = User.find_by_id(@user1)
  user.vacationdays.should == 20
end

When /^I click to delete a craftsman entry$/ do
  find_button("#{User.last.name}").click
end

And /^I confirm the delete$/ do
  #page.driver.browser.switch_to.alert.accept
end


Then /^the record should still persist in the database$/ do
  user = User.find_by_name("george")
  user.name.should == "george"
end

Then /should be logically deleted/ do
  User.last.deleted.should == true
end

Then /^show me the page$/ do
  save_and_open_page
end
