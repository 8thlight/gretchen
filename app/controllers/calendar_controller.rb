class CalendarController < ApplicationController
  
  def home
    if params[:message] == "invalid_credentials"
      flash.now[:notice] = 'Invalid Credentials to Access Site' 
    end
  end

  def vacations
    if !current_user
      redirect_to root_url, :notice => "You must log in to see this page"
    end 
  end
end
