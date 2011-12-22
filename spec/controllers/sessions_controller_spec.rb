require 'spec_helper'

describe SessionsController do

  #TESTED IN CUCUMBER
  describe "Gmail user" do
    before(:each) do
      @gmailuser = User.new(:name => "Test User", :email => "test@not_8thlight.com", :vacationdays => 1)
      @gmailuser.save(:validate => false)
      OmniAuth.config.mock_auth[:google_oauth2] = {
        "provider"=>"google",
        "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
        "info"=>{"email"=>"test@not_8thlight.com", "first_name"=>"Test", "last_name"=>"User", "name"=>"Test User"},
        "credentials"=>{"token"=>"tookkeeeennnnn"}
      }
    end


  end
  describe "8th Light User" do
    before(:each) do  
      @lightuser = User.create!(:name => "Test User", :email => "test@8thlight.com", :vacationdays => 1)
      OmniAuth.config.mock_auth[:google_oauth2] = {
        "provider"=>"google",
        "uid"=>"http://xxxx.com/openid?id=118181138998978630963",
        "info"=>{"email"=>"test@8thlight.com", "first_name"=>"Test", "last_name"=>"User", "name"=>"Test User"},
        "credentials"=>{"token"=>"tookkeeeennnnn"}
      }
    end
  end
end
