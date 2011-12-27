class VacationMailer < ActionMailer::Base
  default from: "gretchen@8thlight.com"
  default to: "vacation@8thlight.com"

  def vacation_email(user)
    @user = user
    @url = edit_user_path(@user)
    @start = @user.vacations.last.start_date
    @end = @user.vacations.last.end_date
    mail(:cc => @user.email, :subject => 'New Vacation')
  end
end
