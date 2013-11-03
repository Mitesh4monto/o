# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strategy do
    title "MyString"
    description "MyText"
    course_id 1
    user_id 1
  end
end
