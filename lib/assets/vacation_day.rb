class VacationDay

  attr_accessor :dates, :google_cal

  def initialize(user, vacation, google_cal)
    @user = user
    @vacation = vacation
    @google_cal = google_cal
    @dates = parse_dates
  end

  def parse_dates
    if(@vacation.start_date != nil && @vacation.start_date != nil)
      start_date = "#{@vacation.start_date.strftime("%Y-%m-%d")}"
      end_date = "#{@vacation.end_date.strftime("%Y-%m-%d")}"
      [start_date, end_date]
    else
      false
    end
  end

  def update_vacationdays
    diff = (@vacation.end_date - @vacation.start_date).to_i
    new = @user.days_used + diff
    @user.update_attribute(:days_used, new)
  end

  def save
    if @vacation.save
      if @google_cal.add_vacation("#{@user.name}'s Time-Off", @dates[0], @dates[1]) == 200 && update_vacationdays
        VacationMailer.vacation_email(@user).deliver
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
