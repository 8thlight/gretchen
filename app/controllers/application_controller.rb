require 'assets/google_api'
require 'assets/vacation_day'
require 'assets/google_mock'
require 'assets/vacation_sync'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def google_com(user)
    if(ENV['RAILS_ENV'] == 'test')
      GoogleMock.new(user, ENV['TEST_KEY'], ENV['TEST_SECRET'])
    else
      if user.email == "san.y4ku@gmail.com"
        calendarId = 'primary'
      else
        calendarId = '8thlight.com_4uqqu52baa6k0qeb0dp3gni138@group.calendar.google.com'
      end
        GoogleCalendar.new(user, ENV['TEST_KEY'], ENV['TEST_SECRET'], calendarId)
    end
  end

end
