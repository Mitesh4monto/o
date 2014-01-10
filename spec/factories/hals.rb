# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity_hal, class: Hal do
    association :halable, factory: :activity
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :activity_from_template_hal, class: Hal do
    association :halable, factory: :from_template_activity
    association :fromable, factory: :template_activity
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :goal_hal, class: Hal do
    association :halable, factory: :goal
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :strategy_hal, class: Hal do
    association :halable, factory: :strategy
    entry "MyText"
    help false
    insights "MyText"
    user
  end

  factory :chapter_hal, class: Hal do
    association :halable, factory: :chapter
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
