class Strategy < ActiveRecord::Base
  acts_as_paranoid
  has_many :activities, :dependent => :destroy  #, :as => :activityable, :dependent => :destroy 
  has_many :goals, :dependent => :destroy
  has_many :activity_sequences, :dependent => :destroy 
  has_many :activity_in_sequences, through: :activity_sequences
  belongs_to :from, class_name: Strategy, :foreign_key => 'from_id'
  belongs_to :user

  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :from_template_hals, :as => :halable #, :dependent => :destroy
  
  
  #  get all activities in strategy combined with all current activities in activity sequences
  def current_activities
    ids = self.activities.pluck(:id) + ActivitySequence.where(strategy_id: self.id).pluck(:current_activity_id)
    if (ids.size > 0)
      ids.delete(nil)  # hack for now
     Activity.where( "id in (#{ids.join(',')})")
   else 
     Activity.where("1=0")  # hack to return empty AR relation.  
   end
  end
  
  # TODO
  # def get_all_activities
  # end/images
  
  def text
    "STRAT"
  end
  
  # checks if a goal with that title exists.  returns that or a new goal in the strategy
  def create_or_use_goal(goal_text)
    goal = Goal.where(title: goal_text, strategy_id: self.id, user_id: self.user.id, course_id: self.course_id).first
    goal ||= Goal.create!(title: goal_text, strategy_id: self.id, user_id: self.user.id, course_id: self.course_id)     
  end
    
  # if a strategy contains a specific activity as defined by same object or same origin of object (course or user)
  def contains_activity(activity)
    self.current_activities.each do |strat_activity|
      if (strat_activity.id == activity.id || strat_activity.from_id == activity.id || (strat_activity.from_id == activity.from_id && activity.from_id != nil))
        return true
      end
    end
    return false
  end
  
  def contains_activity_sequence(as)
    self.activity_sequences.each do |strat_as|
      if (strat_as.id == as.id || strat_as.from_id == as.id || (strat_as.from_id == as.from_id && as.from_id != nil))
        return true
      end
    end
    return false    
  end
  
  def contains_customizations
    self.current_activities.any? {|activity| !activity.customization.blank?}
  end
  
  # def copy_activity_to_strategy(activity)    
  #   strat_activity = activity.dup
  #   if (activity.from_id.nil?)
  #     strat_activity.from_id = activity.id
  #     strat_activity.save
  #   end
  #   self.activities << strat_activity
  # end
  
  def add_activity(activity)
    self.activities << activity
  end
    
  
  def self.c    
    s = Strategy.create()

    g = Goal.create(:title => "important")
    g2 = Goal.create(:title => "not very")
    
    a1 = Activity.create(:title => "title1111")
    g.activities << a1
    s.activities << a1
    a2 = Activity.create(:title => "title2222")
    g2.activities << a2
    s.activities << a2
    
    g3 = Goal.create(:title => "goal 3")
    a1 = Activity.create(:title => "title3333")
    a2 = Activity.create(:title => "imp activity")
    a3 = Activity.create(:title => "another act")
    g3.activities << a1
    s.activities << a2
    s.activities << a3
    stratact = Activity.create(:title => "stratact")
    s.activities << stratact
    s
  end

def print
  puts "user: #{self.user_id}"
  puts "activities: "
  self.current_activities.each {|activity| activity.print}
end
  
end
