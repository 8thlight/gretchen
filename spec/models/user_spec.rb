require 'spec_helper'

describe User do
  describe User do

  before(:each) do
    @attr = { :name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10, :token => "token", :refresh_token => "rtoken" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a valid 8thlight email" do
    no_name_user = User.new(@attr.merge(:email => "user@not8thlight.com"))
    no_name_user.should_not be_valid
  end
end

   describe "vacation days associations" do

    before(:each) do
      @attr = { :name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10 }
      @user = User.create(@attr)
    end

    it "should have a vacations attribute" do
      @user.should respond_to(:vacations)
    end
  end 
end
