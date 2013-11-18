# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chapter do
    strategy_id 1
    title "MyString"
    description "MyText"
    ismainchapter false
    element_order 1
  end
end
