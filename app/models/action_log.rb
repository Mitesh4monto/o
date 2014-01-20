class ActionLog < ActiveRecord::Base
  belongs_to :loggable, :polymorphic => true
  belongs_to :user

  # log the creation of a new object
  def self.log_create(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "create", :link => link)
    al.loggable = obj
    al.save
  end
  
  # log the update of an object
  def self.log_update(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "update", :link => link)
    al.loggable = obj
    al.save
  end
  
  # log the deletion of an object
  def self.log_destroy(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "destroy", :link => link)
    al.loggable = obj
    al.save
  end
  
end
