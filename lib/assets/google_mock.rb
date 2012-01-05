require 'assets/google_api'

class GoogleMock < GoogleCalendar
  attr_accessor :id_array

  def initialize(user, client_key, client_secret, bad = false)
    @user = user
    @bad = bad
    @result = OpenStruct.new
    @result.data = OpenStruct.new
    @id_array = []
    if client_key != ENV['TEST_KEY'] then return false end
    if client_secret != ENV['TEST_SECRET'] then return false end
    if user['token'] == nil then return false end
    if user['refresh_token'] == nil then return false end
  end

  def get_cal_data
    if @bad
      @result.status = 400
    else
      @result.status = 200
    end
    @result
  end

  def add_vacation(summary, start_date, end_date)
    if @bad
      @result.status = 400
    else
      @result.status = 200
      @result.data = OpenStruct.new
      @result.data.id = "abunchof123andletters"
    end
    @result
  end

  def get_single_event(id)
    if id != "abunchof123andletters"
      @result.status = 400
    else
      @result.status = 200
    end
    @result
  end

  def delete_event(id)
    if @bad
      @result.status = 400
    else
      @result.status = 204
      @id_array.delete(id)
    end
    @result
  end

  def add_array_of_test_vacations(array)
    array.each do |v|
      @id_array << v.google_id
    end
  end

end
