class ActivitySequence < ActiveRecord::Base
  acts_as_orderable
  has_many :activities, order: 'position'
  belongs_to :strategy
  belongs_to :user
  belongs_to :from, class_name: Strategy, :foreign_key => 'from_id'
  has_many :copied_activity_sequences, class_name: Activity, :foreign_key => 'from_id'
  belongs_to :current_activity, class_name: Activity, :foreign_key => 'current_activity_id'

  
  # add at end of list
  def add_activity(activity)    
    if (activities.size == 0) then
      self.current_activity = activity
    end
    self.activities << activity
  end
  
  def get_current()
    self.current_activity
  end
  
  
  # TODO ellse?
  def set_current(activity)
    if (self.activities.include?(activity)) then
      self.current_activity = activity
    end      
  end
   
  def get_ordered_activities
    self.activities
  end 
  
end