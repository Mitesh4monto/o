# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:random_string) {|n| LoremIpsum.generate }

  factory :chapter do
    association :strategy, factory: :user_strategy
    
    title "MyString"
    description "MyText"
    element_order 1
  end

  factory :chapter_template, class: Chapter do
    association :strategy, factory: :course_strategy
    title "MyString"
    description "MyText"
  end

  factory :chapter_from_template, class: Chapter do
    title "MyString"
    description "MyText"
    association :from, factory: :chapter_template
  end

end
