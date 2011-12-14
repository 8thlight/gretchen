class CalendarController < ApplicationController
  
  def home
  
  end

  def vacations
    if !current_user
      redirect_to root_url, :notice => "You must log in to see this page"
    end 
  end

end
