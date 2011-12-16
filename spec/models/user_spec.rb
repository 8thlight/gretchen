require 'spec_helper'

describe User do
   describe "micropost associations" do

    before(:each) do
      @attr = { :name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10 }
      @user = User.create(@attr)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
  end 
end
