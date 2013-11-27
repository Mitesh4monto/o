# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_hal, class: Hal do
    association :halable, factory: :activity
    # halable_type "Activity"
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :chapter_hal, class: Hal do
    association :halable, factory: :main_chapter
    entry "MyText"
    help false
    insights "MyText"
    user
  end
  
  factory :hal do
    entry "MyText"
    help false
    insights "MyText"
    user
  end
  
end
