describe("DatePicker", function() {
  it("is Enabled after click", function() {
    loadFixtures("date_picker_test.html");
    setVacationDatePickers();
    $("#vacation_start_date").trigger("click");
    expect($("#vacation_start_date").datepicker('isDisabled')).toBeFalsy();
  });

  it("should use the proper date format", function() {
    loadFixtures("date_picker_test.html");
    setVacationDatePickers();
    $("#vacation_start_date").trigger("click");
    expect($("#vacation_start_date").datepicker("option", "dateFormat")).toEqual("dd/mm/yy");
  });

});
