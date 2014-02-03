class Comment < ActiveRecord::Base
  # acts_as_paranoid
  acts_as_paranoid
  include ActionLogging
  has_many :action_logs, :as => :loggable, :dependent => :destroy
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  attr_accessible :body
  

  # text used for updates
  def text
    self.body
  end

end
