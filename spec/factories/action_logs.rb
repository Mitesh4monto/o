# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :action_log do
    user
    action "create"
    association :loggable, factory: :hal
  end

  factory :action_log_about_course_activity do
    user
    action "create"
    association :loggable, factory: :template_activity
  end

end
