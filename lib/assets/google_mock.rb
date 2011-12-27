require 'assets/google_api'

class GoogleMock < GoogleCalendar 
  def initialize(user, client_key, client_secret, bad = false)
    @user = user
    @bad = bad
    if client_key != ENV['TEST_KEY'] then return false end
    if client_secret != ENV['TEST_SECRET'] then return false end
    if user['token'] == nil then return false end
    if user['refresh_token'] == nil then return false end
  end

  def get_cal_data
    200
  end

  def add_vacation(summary, start_date, end_date)
    if @bad
      400
    else
      200
    end
  end

end
