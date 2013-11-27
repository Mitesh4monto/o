# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:random_string) {|n| LoremIpsum.generate }

  factory :chapter do
    strategy
    title "MyString"
    description "MyText"
    element_order 1
  end

  factory :main_chapter do
    title "MyString"
    description "MyText"
  end

  factory :main_chapter_template, class: MainChapter do
    title "MyString"
    description "MyText"
  end

  factory :main_chapter_from_template, class: MainChapter do
    title "MyString"
    description "MyText"
    association :from, factory: :main_chapter_template
  end

  # factory :main_chapter_user_strategy, class: MainChapter do
  #   association :strategy, factory: :user_strategy    
  #   title "MyString"
  #   description "MyText"
  # end
  # 


  # factory :main_chapter do
  #   strategy
  #   title { generate(:random_string) }
  #   description { generate(:random_string) }
  # end
end
