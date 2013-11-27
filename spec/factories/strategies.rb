# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strategy do
    title "MyString"
    description "MyText"
    main_chapter
    user
  end

  
  
end
