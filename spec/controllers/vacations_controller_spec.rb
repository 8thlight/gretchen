require 'spec_helper'

describe VacationsController do
  before(:each) do
    @boss = User.create!(:name => "A guy", :email => "guy@8thlight.com", :vacationdays => 10, :uid => "123456", :provider => "google_oauth2")
    @vacation = {:start_date => "25/12/2011", :end_date => "27/12/2011", :google_id => "abunchof12384andletters"}
    session[:user_id] = @boss.id
  end

  it "should successfully create a vacation" do
    lambda do
      post :create, :vacation => @vacation
    end.should change(Vacation, :count).by(+1)
  end

  it "should redirect on successful creation" do
    post :create, :vacation => @vacation
    response.should redirect_to(user_path(@boss))
  end

  it"should flash success on creation" do
    post :create, :vacation => @vacation
    flash[:success].should == "Vacation Period Updated"
  end


  it"should flash fail on failed creation" do
    @vacation[:start_date] = ""
    post :create, :vacation => @vacation
    flash[:error].should == "Vacation Update Error"
  end


  it "should not create a date of wrong format" do
    @attr = {:start_date => "", :end_date => "27/12/2011"}
    post :create, :vacation => @attr
    @boss.vacations.last.should == nil
  end

  it "should delete vacations" do
    bye = Vacation.create(@vacation)
    @time = Time.parse("Dec 25 2011")
    Time.stub!(:now).and_return(@time)
    lambda do
      delete :destroy, :id => bye
    end.should change(Vacation, :count).by(-1)
  end
end


