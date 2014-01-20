module ActionLogging
  # Module to allow logging of creates, updates, destroys
  
  def self.included(base)
    base.class_eval do
      after_create :log_create
      after_update :log_update
      before_destroy :log_destroy
    end
  end

  # logging callbacks to add actions to ActionLog
  def log_create
    ActionLog.log_create(self)
  end
  
  def log_destroy
    ActionLog.log_destroy(self)
  end
  
  def log_update
    ActionLog.log_update(self)
  end


end