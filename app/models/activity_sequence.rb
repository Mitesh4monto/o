class ActivitySequence < ActiveRecord::Base
  has_many :activity_in_sequences,  order: 'act_seq_order'
  belongs_to :strategy
  belongs_to :user
  belongs_to :from, class_name: ActivitySequence, :foreign_key => 'from_id'
  has_many :copied_activity_sequences, class_name: Activity, :foreign_key => 'from_id'
  belongs_to :current_activity, class_name: ActivityInSequence, :foreign_key => 'current_activity_id'


  amoeba do
    enable
    nullify :user_id
  end


  def activities
    self.activity_in_sequences.reorder(:act_seq_order)
  end
      
  # Add an activity to the end of an activity sequence, or create an activity sequence with both
  def self.add_activity_to_sequence_with(activity, existing_act)
    if existing_act.activity_sequence_id
      activity.type = "ActivityInSequence"
      activity.activity_sequence_id = existing_act.activity_sequence_id
    else
      as = ActivitySequence.create(:user_id => existing_act.user_id, :strategy_id => existing_act.strategy_id)
      existing_act.activity_sequence_id = as.id
      activity.type = "ActivityInSequence"
      existing_act.type = "ActivityInSequence"
      existing_act.save!
      activity.activity_sequence_id = as.id
      as.current_activity = as.activity_in_sequences.first
      as.save
    end
  end
      

  # delete activity, remove from sequence and if it was current, set new current
  def remove_activity(activity)    
    if (self.current_activity == activity)
      if has_next?
        set_next 
      elsif has_previous?
        set_previous
      else
        self.destroy  #last activity got removed, no point in existing alone
      end
    end
    self.activity_in_sequences << activity
  end
  
  def get_current()
    self.current_activity
  end
  
  def has_previous?
    self.current_activity.higher_item != nil
  end
  def has_next?    
    self.current_activity.lower_item != nil
  end
  def set_next
    if has_next?
      position= self.current_activity.position
      self.current_activity.position = nil
      self.current_activity.strategy_id = nil
      self.current_activity.save      
      self.current_activity = self.current_activity.lower_item
      self.current_activity.position = position
      self.current_activity.strategy_id = self.strategy_id    
      self.current_activity.save
      self.save
    end
  end
  
  def set_previous
    if has_previous?
      position= self.current_activity.position
      self.current_activity.position = nil
      self.current_activity.strategy_id = nil
      self.current_activity.save      
      self.current_activity = self.current_activity.higher_item
      self.current_activity.position = position
      self.current_activity.strategy_id = self.strategy_id    
      self.current_activity.save
      self.save
    end
  end
  
  def set_to_first
    self.set_current(self.activities.first)
  end
  
  # TODO ellse?
  def set_current(activity)
    if (self.activity_in_sequences.include?(activity)) then
      activity.strategy_id = self.strategy_id
      activity.save
      self.current_activity.strategy_id = nil
      self.current_activity.save
      self.current_activity = activity
      self.save
    end      
  end
   
end