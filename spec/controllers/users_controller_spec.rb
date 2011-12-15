require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'Index'" do
    before do
      @boss = User.create!(:name => "The Boss", :email => "theboss@8thlight.com", :uid => "12345", :provider => "google_oauth2")
      @boss.toggle!(:admin)
      @notboss = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :uid => "123456", :provider => "google_oauth2")
    end

    it "should be successful if admin" do
      session[:user_id] = @boss.id
      get :index
      response.should have_selector('h1', :content => "Listing users")
    end

    it "should redirect to root if not admin" do
      session[:user_id] = @notboss.id
      get :index
      response.code.should == "302"
    end

  end

  describe "GET 'Show'" do
    before(:each) do
      @boss = User.create!(:name => "The Boss", :email => "theboss@8thlight.com", :uid => "123456", :provider => "google_oauth2")
      @boss.toggle!(:admin)
      @notboss = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :uid => "12345", :provider => "google_oauth2")
      @malicious = User.create!(:name => "Evil Hacker", :email => "stealinyourvacation@8thlight.com", :uid => "15", :provider => "google_oauth2")
    end

    it "should be successful if admin" do
      session[:user_id] = @boss.id
      get :show, :id => @notboss
      response.should be_success
    end

    it "should redirect to root if not admin" do
      session[:user_id] = @malicious.id
      get :show, :id => @notboss.id
      response.code.should == "302"
    end

    it "should be successful if current user" do
      session[:user_id] = @notboss.id
      get :show, :id => @notboss
      response.should be_success
    end

  end

  describe "GET 'Edit'" do
    before do
      @boss = User.create!(:name => "The Boss", :email => "theboss@8thlight.com", :uid => "123456", :provider => "google_oauth2")
      @boss.toggle!(:admin)
      @notboss = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :uid => "12346", :provider => "google_oauth2")
      @malicious = User.create!(:name => "Evil Hacker", :email => "stealinyourvacation@8thlight.com", :uid => "1256", :provider => "google_oauth2")
    end

    it "should be successful if admin" do
      session[:user_id] = @boss.id
      get :edit, :id => @boss
      response.should be_success
    end

    it "should be successful if current user" do
      session[:user_id] = @notboss.id
      get :show, :id => @notboss
      response.should be_success
    end

    it "should redirect to root if not admin" do
      session[:user_id] = @malicious.id
      get :show, :id => @notboss.id
      response.code.should == "302"
    end
  
  end
    
  describe "PUT 'update'" do

    before(:each) do
      @user = User.create!(:name => "Not The Boss", :email => "nottheboss@8thlight.com", :uid => "12346", :provider => "google_oauth2")
      session[:user_id] = @user.id
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :name => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {:name => "Evil Hacker", :email => "stealinyourvacation@8thlight.com" }
      end
      
      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
      end
      
      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "GET 'New'" do
    before(:each) do
      @boss = User.create!(:name => "The Boss", :email => "theboss@8thlight.com", :uid => "123456", :provider => "google_oauth2")
      @boss.toggle!(:admin)
      @newguy = User.new
      @attr = {:name => "New Guy", :email => "n00b@8thlight.com", :vacationdays => 10 }
      @failed = {:name => "New Guy" }
    end

    it "should create a new user" do
      put :create, :user => @attr
      test = User.find_by_name("New Guy")
      test.email.should == "n00b@8thlight.com"
    end

    it "should redirect to new user page" do
      put :create, :user => @attr
      test = User.find_by_name("New Guy")
      response.should redirect_to(user_path(test))
    end

    it "should render new if failed" do
      put :create, :user => @failed
      test = User.find_by_name("New Guy")
      response.should render_template('new')
    end

  end

  describe "destroy" do

  end


end

