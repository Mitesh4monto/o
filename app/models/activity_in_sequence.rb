 class ActivityInSequence < Activity  
   acts_as_list :scope => :activity_sequence, :column => 'act_seq_order'
   acts_as_paranoid
   attr_accessible :activity_sequence
   belongs_to :activity_sequence
   delegate :strategy, to: :activity_sequence


   # creates activity in sequence for user (not set in a sequence)
   def copy_to_user(user)
     activity = self.dup
     activity.title = self.title
     activity.user_id = user.id
     activity.from_id = self.id
     activity.activity_sequence = nil
     activity.strategy_id = nil
     activity.course_id = self.course_id
     activity.goal = self.goal.copy_to_user(user) if self.goal
     activity.save
     activity
   end
 

 end
 