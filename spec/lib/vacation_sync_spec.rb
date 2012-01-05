require 'spec_helper'
require 'assets/google_mock'
require 'assets/vacation_sync'

describe VacationDay do

  before(:each) do
    @test = User.create!(:name => "Test User", :email => "test@8thlight.com", :vacationdays => 10, :uid => "12345", :provider => "google_oauth2", :token => "tokenid", :refresh_token => "refreshtoken")
    vacation = {:start_date => "11/12/2011", :end_date => "25/12/2011", :google_id => "abunchof123andletters"}
    @test.vacations.build(vacation).save
    vacation = {:start_date => "22/04/2011", :end_date => "25/04/2011", :google_id => "abunchof123andletters"}
    @test.vacations.build(vacation).save
    vacation = {:start_date => "12/07/2011", :end_date => "19/07/2011", :google_id => "abunchof123andletters"}
    @test.vacations.build(vacation).save
    @google_mock = GoogleMock.new(@test, ENV['TEST_KEY'], ENV['TEST_SECRET'])
    @sync = VacationSync.new(@test, @google_mock)
  end

  it "should check if dates still exist in google calendar" do
    @sync.check_dates
    @test.vacations.count.should == 3
  end

  it "should delete dates if they don't exist" do
    @test.vacations.last.update_attribute(:google_id, "123deletedID")
    @sync.check_dates
    @test.vacations.count.should == 2
  end
end
