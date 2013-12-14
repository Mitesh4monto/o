Given(/^I have Activities titled work out, eat more$/) do
  titles.split(', ').each do |title|
    current_user.strategy.add_activity(Activity.create!(:title => title, :description => "deeeeeesssssssc"))
   end
end

When(/^I go to my strategy$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end