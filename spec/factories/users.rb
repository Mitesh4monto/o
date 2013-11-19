# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "MyString"
<<<<<<< HEAD
    email "my@email.com"
    password "password"
=======
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39
  end
  
  factory :reguser, class: User do
    name "other"
  end
  
end
