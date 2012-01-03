class VacationMailer < ActionMailer::Base
  default from: "gretchen@8thlight.com"
  default to: "vacation@8thlight.com"

  def vacation_email(user)
    @user = user
    @url = edit_user_path(@user)
    @start = @user.vacations.last.start_date
    @end = @user.vacations.last.end_date
    mail(:from => 'gretchen@8thlight.com', :cc => @user.email, :subject => 'New Vacation')
  end

  def vacation_reminder(user)
    @user = user
    @url = edit_user_path(@user)
    @start = @user.vacations.last.start_date
    @end = @user.vacations.last.end_date
    mail(:from => 'gretchen@8thlight.com', :cc => @user.email, :subject => 'Vacation Reminder', :template_name => 'vacation_reminder')
  end

  def remind(current_time)
    users = User.all
    users.each do |user|
      user.vacations.each do |vacation|
        if (vacation.start_date - current_time).to_int == 7
          vacation_reminder(user).deliver
        end
      end
    end
  end

end
