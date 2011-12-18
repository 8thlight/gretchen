require 'spec_helper'

describe User do
   describe "micropost associations" do

    before(:each) do
      @attr = { :name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10 }
      @user = User.create(@attr)
    end
  end 
end
