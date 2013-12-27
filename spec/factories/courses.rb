# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "MyString"
    user
    description "some description"
    about_the_author "about the um.. author"
    # course_strategy
  end
end
