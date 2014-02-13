# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  # sequence :email do
  #   "email#{rand(10000).to_s}@factory.com"
  # end
  
  factory :user do
    name "MyString"
    email {Faker::Internet.email}
    password 'changeme'
    password_confirmation 'changeme'
  end
  
  factory :user2, class: User do
    name "other"
    email {Faker::Internet.email}
    password "password"
  end

  factory :user3, class: User do
    name "other"
    email {Faker::Internet.email}
    password "password"
  end

  factory :user_following_others, class: User do
    association :following, factory: :user    
    name "follower"
    email {Faker::Internet.email}
    password "password"
    following
  end
  
end
