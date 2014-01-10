# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do
    "email#{rand(1000).to_s}@factory.com"
  end
  
  factory :user do
    name "MyString"
    email
    password 'changeme'
    password_confirmation 'changeme'
  end
  
  factory :user2, class: User do
    name "other"
    email
    password "password"
  end
  
end
