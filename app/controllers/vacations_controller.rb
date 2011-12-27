class VacationsController < ApplicationController

  def create
    user = current_user
    date = VacationDay.new(user, user.vacations.build(params[:vacation]), google_com(user))
    if date.save
      flash[:success] = "Vacation Period Updated"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Vacation Update Error"
      redirect_to "/users/#{user.id}"
    end
  end

  def destroy
    Vacation.find_by_id(params[:id]).destroy
    redirect_to "/users/#{current_user.id}"
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
