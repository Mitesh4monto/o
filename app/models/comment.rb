class Comment < ActiveRecord::Base
  # acts_as_paranoid
  acts_as_paranoid
  include ActionLogging
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  attr_accessible :body
  
  LOGCREATE = true

  # text used for updates
  def text
    self.body
  end


  # def log_create
  #   ActionLog.log_create(self) if self.privacy != 0
  # end

end
