# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timing do
    activity factory: :activity
    kind_of_timing "MyString"
    info "MyString"
  end
end
