# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    chapter_id 1
    title "MyString"
    description "MyText"
    element_order 1
    # goal_id 1
    # from_template_activity_id 1
  end
end
