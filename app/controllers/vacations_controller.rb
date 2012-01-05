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
    vacation = Vacation.find_by_id(params[:id])
    user = current_user
    VacationDay.new(user, vacation, google_com(user)).delete_vacation
    redirect_to "/users/#{current_user.id}"
  end

end
