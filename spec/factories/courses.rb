# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "MyString"
    user
    overview "ooyeah"
    description "some description"
    about_the_author "about the um.. author"

    after(:create) do |course, evaluator|
      activities = create_list(:activity, 3, strategy: course.strategy, course: course, user: course.user)
    end
  end
  
end
