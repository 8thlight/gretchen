require 'assets/vacation_day'

class VacationSync

  def initialize(user, google_cal)
    @user = user
    @vacations = user.vacations
    @google_cal = google_cal
  end

  def check_dates
    @vacations.each do |vacation|
      result = @google_cal.get_single_event(vacation.google_id)
      if result.status == 400 || result.data.status == 'cancelled'
        VacationDay.new(@user, vacation, @google_cal).delete_vacation
      end
    end
  end
end
