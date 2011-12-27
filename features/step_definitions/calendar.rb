Then /^it should contain the "([^"]*)" google calendar$/ do |name|
  test = /8th Light Time Off/.match(page.driver.source)
  test.to_s.should == name
end

Then /^it should display "([^"]*)"$/ do |title|
  page.should have_content(title)
end

