require 'spec_helper'

describe Vacation do

  before(:each) do
    @user = User.create!(:name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10)
    @attr = {:start_date => "01/02/2011", :end_date => "01/02/2011"}
  end

  it "should create a new instance given valid attributes" do
    @user.vacations.create!(@attr)
  end

  it "should require start_date and end_date" do
    no_start_date  = Vacation.new(@attr.merge(:start_date => ""))
    no_start_date.should_not be_valid
    no_end_date  = Vacation.new(@attr.merge(:end_date => ""))
    no_end_date.should_not be_valid
  end

  describe "user associations" do
    before(:each) do
       @vacation = @user.vacations.create(@attr)
    end

    it "should have a user attribute" do
      @vacation.should respond_to(:user)
    end

    it "should have the right associated user" do
      @vacation.user_id.should == @user.id
      @vacation.user.should == @user
    end
  end
end
