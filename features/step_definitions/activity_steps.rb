Given /^I fill in "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  fill_in arg1, :with => arg2
end

Given /^I am on the addactivity page$/ do
  visit '/activities/new'
end

Given /^I am on the my plan page$/ do
  visit myp_path
end

Given(/^I have at least one activity in my plan$/) do
  visit '/activities/new'
  fill_in "Title", :with => "my title"
  fill_in "Timing expression", :with => "nonsense"
  fill_in "activity_description", :with => "descri"
  click_button "Create Activity"
end


Then /^I should see a successful deletion message$/ do
  page.should have_content "Activity was successfully deleted"
end

Then /^I should see a successful addition message$/ do
  page.should have_content "Activity was successfully created"
end

Then /^I should see on page "(.*?)"$/ do |arg1|
  page.should have_content arg1
end

Then /^I should be on my plan page$/ do
  puts page.current_path
  assert page.current_path == myp_path
end


Then /^page should have activity titled "(.*?)"$/ do |arg1|
  page.should have_content arg1
end

Then /^page should not have activity titled "(.*?)"$/ do |arg1|
  page.should_not have_content arg1
end

When(/^I press "(.*?)"$/) do |arg1|
  click_button arg1
end

When /^I click link "(.*?)"$/ do |arg1|
  click_link arg1
end

When /^I click image "(.*?)"$/ do |link|
 find(:xpath, "//img[@title = '#{link}']/parent::a").click()
   # find("img[@alt='#{link}']").click
end

