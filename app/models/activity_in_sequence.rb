 class ActivityInSequence < Activity  
   acts_as_list :scope => :activity_sequence, :column => 'act_seq_order'
   acts_as_paranoid
   belongs_to :activity_sequence

 end
 