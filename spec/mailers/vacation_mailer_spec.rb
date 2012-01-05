require "spec_helper"

describe VacationMailer do
  before(:each) do
    @user = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :vacationdays => 10)
    @user.vacations.new(:start_date => '25/12/2011', :end_date => '27/12/2011', :google_id => "abunchof12384andletters").save
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

  it "should successfully use the vacation reminder template" do
    email = VacationMailer.vacation_reminder(@user).deliver
    ActionMailer::Base.deliveries.should_not be_empty

    ['vacation@8thlight.com'].should == email.to
    email.subject.should == 'Vacation Reminder'
    email.body.should have_content("#{@user.name}")
    email.body.should have_content("From #{@user.vacations.last.start_date} to #{@user.vacations.last.end_date}.")
    email.body.should have_content("This is a reminder that your vacation is a week from now.")
  end

  it "send email within 7 days of start date" do
    date = Time.now.to_date
    start_date = date + 7
    @attr = { :start_date => "#{start_date.strftime("%d/%m/%Y")}", :end_date => "27/12/2020", :google_id => "abunchof12384andletters"}
    @user.vacations.new(@attr).save
    VacationMailer.remind(date)
    ActionMailer::Base.deliveries.should_not be_empty
    email = ActionMailer::Base.deliveries.last
    email.subject.should == "Vacation Reminder"
  end


end
