# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    chapter
    title "MyString"
    description "MyText"
    element_order 1
    user
    # from template_activity
    # goal_id 1
    # from_template_activity_id 1
  end

  factory :template_activity, class: Activity do
    chapter
    title "MyString3"
    description "MyText2"
    element_order 2
    user
  end  

  factory :chapterless_activity, class: Activity do
    title "MyString3"
    description "MyText2"
    element_order 2
    user
  end  

  factory :from_template_activity, class: Activity do
    chapter
    title "MyString"
    description "MyText"
    element_order 1
    user
    association :from, factory: :template_activity
    # from template_activity
    # goal_id 1
    # from_template_activity_id 1
  end
  
end
