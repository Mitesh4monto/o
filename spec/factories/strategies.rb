# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_strategy do
    description "MyText"
    user
  end

  factory :strategy do
    description "MyText"
  end

end
