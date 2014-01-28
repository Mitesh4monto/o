class Strategy < ActiveRecord::Base
  acts_as_paranoid
  has_many :activities, :dependent => :destroy  #, :as => :activityable, :dependent => :destroy 
  has_many :activity_sequences, :dependent => :destroy 
  belongs_to :from, class_name: Strategy, :foreign_key => 'from_id'

  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :from_template_hals, :as => :halable #, :dependent => :destroy
  
  amoeba do
    enable
    nullify :user_id
    exclude_field :hals
  end
  
  def strategy
    self
  end
  
  def text
    
  end
  
  # if a strategy contains a specific activity as defined by same object or same origin of object (course or user)
  def contains_activity(activity)
    self.activities.each do |strat_activity|
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
    self.activities.any? {|activity| !activity.customization.blank?}
  end
  
  def copy_activity_to_strategy(activity)
    
    strat_activity = activity.dup
    if (activity.from_id.nil?)
      strat_activity.from_id = activity.id
      strat_activity.save
    end
    self.activities << strat_activity
  end
  
  def add_activity(activity)
    self.activities << activity
  end
  
  # remove an activity from a strategy
  def delete_activity(activity)    
    self.activities.destroy(activity)
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
  self.activities.each {|activity| activity.print}
end
  
end
