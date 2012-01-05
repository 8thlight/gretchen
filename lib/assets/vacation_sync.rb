
class VacationSync

  def initialize(user, google_cal)
    @vacations = user.vacations
    @google_cal = google_cal
  end

  def check_dates
    @vacations.each do |vacation|
      result = @google_cal.get_single_event(vacation.google_id)
      vacation.destroy if result.status == 400 || result.data.status == 'cancelled'
    end
  end

  def delete_date(id)
    result = @google_cal.delete_event(id)
  end
end
