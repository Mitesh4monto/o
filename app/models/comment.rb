class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  attr_accessible :body
  

  # text used for updates
  def text
    self.body
  end

end
