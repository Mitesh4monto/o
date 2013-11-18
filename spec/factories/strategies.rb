# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strategy do
    title "MyString"
    description "MyText"
    # course_id 1
    main_chapter
    user
  end

  
  factory :main_chapter do
    title "MyString"
    description "MyText"
  end
  
end
