class Goal < ActiveRecord::Base
  acts_as_paranoid
  # include ActionLogging
  belongs_to :strategy
  belongs_to :course

  belongs_to :from, class_name: Goal, :foreign_key => 'from_id'
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :from_template_hals, :as => :halable #, :dependent => :destroy
  has_many :activities #, :as => :activityable, :dependent => :destroy 
  has_one :user
  
  
  def log_create
    if (self.strategy.type == "UserStrategy")
      ActionLog.log_create(self)         
    end    
  end
  
  
  
  # add a hal to list of hals for activity
  def hal_about(hal)
    hal.fromable = self.get_hierarchical_from
    self.hals << hal
  end

  def self.foc(strategy, title)
    Goal.find_or_create_by!(title: title, strategy: strategy.id, user_id: strategy.user_id)
  end
  
  def copy_to_user(user)
      goal = Goal.where(title: self.title, strategy_id: user.strategy.id, user_id: user.id, course_id: self.course_id).first
      goal ||= Goal.create!(title: self.title, strategy_id: user.strategy.id, user_id: user.id, course_id: self.course_id) 
  end

end
