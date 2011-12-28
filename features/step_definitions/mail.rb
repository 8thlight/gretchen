Then /^I should recieve an e-mail confirmation$/ do
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

Then /^I should recieve an e-mail reminder$/ do
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.deliveries.clear
  date = Time.now.to_date
  VacationMailer.remind(date).deliver
  email = ActionMailer::Base.deliveries.last
  email.from.should == ['gretchen@8thlight.com']
  email.cc.should == ["#{@user.email}"]
  email.subject.should == "Vacation Reminder"
  email.body.should have_content("From #{@user.vacations.last.start_date} to #{@user.vacations.last.end_date}.")
end

And /^I have a vacation that starts in 7 days$/ do
  date = Time.now.to_date
  start_date = date + 7
  @attr = { :start_date => "#{start_date.strftime("%d/%m/%Y")}", :end_date => "27/12/2020"}
  @user.vacations.new(@attr).save
end


