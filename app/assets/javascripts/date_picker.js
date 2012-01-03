	$(function() {
    setVacationDatePickers();
  });

  setVacationDatePickers = function() {
		$( "#vacation_start_date" ).datepicker({ dateFormat: 'dd/mm/yy' });
    $( "#vacation_end_date" ).datepicker({ dateFormat: 'dd/mm/yy' });
  }
