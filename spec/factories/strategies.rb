# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_strategy do
    title "MyString"
    description "MyText"
    user
  end

  factory :strategy do
    title "MyString"
    description "MyText"
  end

end
