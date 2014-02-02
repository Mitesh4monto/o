Given(/^I am on the contact us page$/) do
  visit '/messages/new'
end

Then(/^I should see a successful send message$/) do
  page.should have_content "Message sent!"
end
