FactoryGirl.define do
  factory :activity_sequence_in_plan, class: ActivitySequence do
    association :strategy, factory: :user_strategy    
    association :current_activity, factory: :activity_in_sequence
    user
  end

  factory :activity_sequence_in_course, class: ActivitySequence do
    association :strategy, factory: :course_strategy    
    association :current_activity, factory: :activity_in_sequence
    user
    course

    after(:create) do |activity_sequence|
        activity_sequence_in_course.activity_in_sequences  = create_list(:activity_in_sequence, 2)
    end
  end
  
end
