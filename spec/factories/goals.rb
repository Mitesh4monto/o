# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    association :goalable, factory: :chapter
    title "MyString"
    description "MyText"
  end
end
