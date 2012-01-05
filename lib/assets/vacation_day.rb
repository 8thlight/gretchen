class VacationDay

  attr_accessor :dates, :google_cal

  def initialize(user, vacation, google_cal)
    @user = user
    @vacation = vacation
    @google_cal = google_cal
  end

  def parse_dates
    if(@vacation.start_date != nil && @vacation.end_date != nil)
      modified_end_date = @vacation.end_date + 1
      start_date = "#{@vacation.start_date.strftime("%Y-%m-%d")}"
      end_date = "#{modified_end_date.strftime("%Y-%m-%d")}"
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
    @dates = parse_dates
    if @vacation.save
      result = @google_cal.add_vacation("#{@user.name}'s Time-Off", @dates[0], @dates[1])
      if result.status == 200 && update_vacationdays
        id = result.data.id
        @vacation.update_attribute(:google_id, id)
        VacationMailer.vacation_email(@user).deliver
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def delete_vacation
    length = @user.days_used - (@vacation.end_date - @vacation.start_date).to_i
    @user.update_attribute(:days_used, length)
    @vacation.destroy
    @google_cal.delete_event(@vacation.google_id)
  end

end
