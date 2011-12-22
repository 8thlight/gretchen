require 'assets/google_api'
require 'assets/vacation_day'
require 'assets/google_mock'

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
