class CommitmentMark < ActiveRecord::Base
  attr_accessible :done_date, :user_id
  belongs_to :cmable, :polymorphic => true
  include ActionLogging
  LOGCREATE = true

end
