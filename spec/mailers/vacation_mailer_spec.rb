require "spec_helper"

describe VacationMailer do
  before(:each) do
    @user = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :vacationdays => 10)
    @user.vacations.new(:start_date => '25/12/2011', :end_date => '27/12/2011').save
  end

  it "should send mail to the user" do
    email = VacationMailer.vacation_email(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty

    [@user.email].should == email.cc
    email.subject.should == 'New Vacation'
  end

  it "should send admin an email" do
    email = VacationMailer.vacation_email(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty

    ['vacation@8thlight.com'].should == email.to
    email.subject.should == 'New Vacation'
  end

  it "should have the correct content" do
    email = VacationMailer.vacation_email(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty

    ['vacation@8thlight.com'].should == email.to
    email.subject.should == 'New Vacation'
    email.body.should have_content("#{@user.name}")
    email.body.should have_content("From #{@user.vacations.last.start_date} to #{@user.vacations.last.end_date}.")
  end

end
