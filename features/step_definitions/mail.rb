Then /^I should recieve e-mail confirmation$/ do
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.deliveries.clear
  VacationMailer.vacation_email(@user).deliver
  email = ActionMailer::Base.deliveries.last
  email.from.should == ['gretchen@8thlight.com']
  email.cc.should == ["#{@user.email}"]
  email.body.should have_content("#{@user.name}")
  email.body.should have_content("From #{@user.vacations.last.start_date} to #{@user.vacations.last.end_date}.")
end
