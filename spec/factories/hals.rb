# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_hal, class: Hal do
    id 1
    halable_id 1
    halable_type "Activity"
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :chapter_hal, class: Hal do
    id 1
    halable_id 1
    halable_type "Chapter"
    entry "MyText"
    help false
    insights "MyText"
    user
  end
  
  factory :hal do
    id 1
    halable_id 2
    halable_type "Activity"
    entry "MyText"
    help false
    insights "MyText"
    user
  end
  
end
