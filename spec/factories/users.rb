# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
  end
  
  factory :reguser, class: User do
    name "other"
  end
  
end
