require 'spec_helper'
require 'assets/google_mock'
require 'assets/vacation_day'

describe VacationDay do

  before(:each) do
    @test = User.create!(:name => "Test User", :email => "test@8thlight.com", :vacationdays => 10, :uid => "12345", :provider => "google_oauth2", :token => "tokenid", :refresh_token => "refreshtoken")
    vacation = {:start_date => "22/12/2011", :end_date => "25/12/2011"}
    @vacation = @test.vacations.build(vacation)
    @google_mock = GoogleMock.new(@test, ENV['TEST_KEY'], ENV['TEST_SECRET'])
  end
  
  it "should initialize with google calendar" do
    date = VacationDay.new(@test, @vacation, @google_mock)
    date.google_cal.should == @google_mock
  end

  it "should correctly parse dates in vacation" do
    date = VacationDay.new(@test, @vacation, @google_mock)
    date.dates[0].should == "2011-12-22"
    date.dates[1].should == "2011-12-25"
  end

  it "should save vacation successfully" do
    date = VacationDay.new(@test, @vacation, @google_mock)
    date.save.should == true
  end

  it "should not save properly on invalid date" do
    @vacation = Vacation.new(:start_date => "", :end_date => "25/12/2011")
    date = VacationDay.new(@test, @vacation, @google_mock)
    date.save.should == false
  end

  it "should undo vacation save if google calendar fails" do
    bad = true
    @google_mock = GoogleMock.new(@test, ENV['TEST_KEY'], ENV['TEST_SECRET'], bad)
    date = VacationDay.new(@test, @vacation, @google_mock)
    date.save.should == false
  end

  it "should subtract user's vacations days correctly" do
    date = VacationDay.new(@test, @vacation, @google_mock)
    ed = @vacation.end_date
    sd = @vacation.start_date
    difference = (ed - sd).to_i
    difference += @test.days_used
    date.save
    @test.days_used.should == difference
  end

  it "should send email on successful creation" do
   date = VacationDay.new(@test, @vacation, @google_mock) 
   date.save
   ActionMailer::Base.deliveries.should_not be_empty
   email = ActionMailer::Base.deliveries.last

   [@test.email].should == email.cc
   ['vacation@8thlight.com'].should == email.to
   email.subject.should == 'New Vacation'
  end

end
