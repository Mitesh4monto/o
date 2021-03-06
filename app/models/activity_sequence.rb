class ActivitySequence < ActiveRecord::Base
  acts_as_paranoid
  has_many :activity_in_sequences, :dependent => :destroy,  order: 'act_seq_order'
  belongs_to :strategy
  belongs_to :user
  belongs_to :from, class_name: ActivitySequence, :foreign_key => 'from_id'
  has_many :copied_activity_sequences, class_name: Activity, :foreign_key => 'from_id'
  belongs_to :current_activity, class_name: ActivityInSequence, :foreign_key => 'current_activity_id'



  #  ordered list of activities in sequence
  def activities
    self.activity_in_sequences.reorder(:act_seq_order)
  end
      
  # Add an activity to the end of an activity sequence, or create an activity sequence with both
  def self.add_activity_to_sequence_with(activity, existing_act)
    if existing_act.activity_sequence_id
      activity.type = "ActivityInSequence"
      activity.activity_sequence_id = existing_act.activity_sequence_id
    else
      # creeat an activity sequence with the same user and strategy as activity
      as = ActivitySequence.create(:user_id => existing_act.user_id, :strategy_id => existing_act.strategy_id)
      existing_act.activity_sequence_id = as.id
      activity.type = "ActivityInSequence"
      existing_act.type = "ActivityInSequence"
      existing_act.strategy_id = nil
      existing_act.save!
      activity.activity_sequence_id = as.id
      as.current_activity = ActivityInSequence.find existing_act.id
      as.save
    end
  end
  
  def add_activity_from_title_description(title, description)
    ais = ActivityInSequence.new(:user_id => self.user_id, :title => title, :description => description, :kind_of_timing => "Other")
    ais.activity_sequence_id = self.id
    ais.save
  end
      
  def copy_to_user(user)
    as = self.dup
    as.save
    as.from_id = self.id
    as.user_id = user.id
    user.strategy.activity_sequences << as
    self.activities.each do |activity|
      new_activity = activity.copy_to_user(user)
      new_activity.activity_sequence_id = as.id
      new_activity.save
    end
    as.set_to_first
    as.save
    as
  end

  # delete activity, remove from sequence and if it was current, set new current
  # can only be called from within a course
  def destroy_activity(activity)
    # hacky  -- only one activiy in seq left after delete => destroy sequence and move last activity out
    if (self.activities.size == 2)      
      remaining_activity = self.activities.first if self.activities.first != activity
      remaining_activity = self.activities.last if self.activities.last != activity
      copied_activity = remaining_activity.dup
      copied_activity.activity_sequence = nil
      copied_activity.strategy_id = self.strategy_id
      copied_activity.type = "Activity"
      copied_activity.course_id = self.strategy.course.id
      copied_activity.becomes(Activity).save
      self.destroy
    else
      #  set first activity as current
      first_activity = self.activities.first if self.activities.first != activity
      first_activity = self.activities.second if self.activities.first != activity      
      self.set_current(first_activity)
      activity.destroy    
    end
  end
  
  def get_current()
    self.current_activity
  end
  
  # has a previous activity in its sequence before current activity
  def has_previous?
    self.current_activity.higher_item != nil
  end

  # has ah activity in its sequence after current activity
  def has_next?    
    self.current_activity.lower_item != nil
  end
  
  #  set current activity to next
  def set_next
    if has_next?
      position= self.current_activity.position
      self.current_activity = self.current_activity.lower_item
      self.current_activity.position = position
      self.current_activity.save
      self.save
    end
  end
  
  # set current activity to previous
  def set_previous
    if has_previous?
      position= self.current_activity.position
      self.current_activity.save      
      self.current_activity = self.current_activity.higher_item
      self.current_activity.position = position
      self.current_activity.save
      self.save
    end
  end
  
  #  set current activity to first in list
  def set_to_first
    self.set_current(self.activities.first)
  end
  
  # TODO ellse?
  def set_current(activity)
    if (self.activity_in_sequences.include?(activity)) then
      position= self.current_activity.position if self.current_activity
      self.current_activity = activity
      self.current_activity.position = position if position
      self.current_activity.save
      self.save
    end      
  end
   
end