Given /^I am on the my courses page$/ do
  visit my_created_courses_path
end

Given(/^I have a created unpublished course$/) do
  visit create_course_path
  fill_in "Name", :with => "my course title"
  fill_in "Overview", :with => "overview nonsense"
  fill_in "About the author", :with => "more author nonsense"
  fill_in "course_description", :with => "descri"
  click_button "Create Course"
end

Given(/^I have a created published course$/) do
  visit create_course_path
  fill_in "Name", :with => "my course title"
  fill_in "Overview", :with => "overview nonsense"
  fill_in "About the author", :with => "more author nonsense"
  fill_in "course_description", :with => "descri"
  check "Published"
  click_button "Create Course"
end

Given /^I am on the newcourse page$/ do
  visit '/courses/new'
end


When /^I click link create a course$/ do
  click_link "create a course"
end

When(/^I check "(.*?)"$/) do |arg1|
  check arg1
end

When(/^I uncheck "(.*?)"$/) do |arg1|
  uncheck arg1
end

When(/^I click created course link$/) do
  click_link "my course title"
end

When(/^I go to the courses page$/) do
  visit courses_path
end

Then /^I should see a successful creation message$/ do
  page.should have_content "Course was successfully created"
end

Then /^I should see a successful course update message$/ do
  page.should have_content "Course was successfully updated"
end


Then /^I should see an error message$/ do
  page.should have_content "errors"
end

Then /^I should see a successful course deletion message$/ do
  page.should have_content "Course was successfully deleted"
end


Then /^page should have course named "(.*?)"$/ do |arg1|
  page.should have_content arg1
end

Then /^page should not have course named "(.*?)"$/ do |arg1|
  page.should_not have_content arg1
end

