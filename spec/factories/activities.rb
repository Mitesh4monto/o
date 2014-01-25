# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activity do
    association :strategy, factory: :user_strategy    
    title "MyString"
    description "MyText"
    element_order 1
    user
    # from template_activity
    # goal_id 1
    # from_template_activity_id 1
  end

  factory :activity_in_goal, class: Activity do
    goal    
    title "MyString"
    description "MyText"
    element_order 1
    user
    # from template_activity
    # goal_id 1
    # from_template_activity_id 1
  end

  factory :template_activity, class: Activity do
    association :strategy, factory: :course_strategy    
    title "MyString3"
    description "MyText2"
    element_order 2
    association :course, factory: :course    
  end  

  factory :template_activity2, class: Activity do
    association :strategy, factory: :course_strategy    
    title "another title"
    description "long description"
    element_order 4
    association :course, factory: :course    
  end  

  factory :from_template_activity, class: Activity do
    association :strategy, factory: :user_strategy
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
