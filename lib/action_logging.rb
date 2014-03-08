module ActionLogging
  # Module to allow logging of creates, updates, destroys
  
  def self.included(base)
    base.class_eval do
      has_many :action_logs, :as => :loggable
      after_create :log_create
      after_update :log_update
      before_destroy :log_destroy
    end
  end

  # logging callbacks to add actions to ActionLog
  def log_create    
    ActionLog.log_create(self) if defined? self.class::LOGCREATE and self.class::LOGCREATE
  end
  
  def log_destroy
    ActionLog.log_destroy(self) if defined? self.class::LOGDESTROY and self.class::LOGDESTROY
  end
  
  def log_update
    ActionLog.log_update(self) if defined? self.class::LOGUPDATE and self.class::LOGUPDATE
  end


end