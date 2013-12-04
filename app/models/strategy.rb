class Strategy < ActiveRecord::Base
  has_many :activities, :as => :activityable, :dependent => :destroy 
  has_many :goals, :as => :goalable, :dependent => :destroy 
  has_many :chapters, :dependent => :destroy 
  belongs_to :from, class_name: Strategy, :foreign_key => 'from_id'

  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :fromhals, :as => :halable #, :dependent => :destroy
  
  amoeba do
    enable
    prepend :title => "Copy of "
    nullify :user_id
    exclude_field :hals
  end
  
  
  def strategy
    self
  end
  
  def add_activity(activity)
    self.activities << activity
  end
  
  # def chapters
  #   self.chapters
  # end
  
  # remove an activity from a strategy
  def delete_activity(activity)    
    self.activities.destroy(activity)
  end
  
  
  def self.c    
    s = Strategy.create(:title => "foo")

    g = Goal.create(:title => "important")
    g2 = Goal.create(:title => "not very")
    
    c1 = Chapter.create(:title => "aaaaa")    
    a1 = Activity.create(:title => "1111")
    g.activities << a1
    a2 = Activity.create(:title => "2222")
    g2.activities << a2
    c1.goals << g
    c1.goals << g2
    s.chapters << c1
    
    c2 = Chapter.create(:title => "bbbb")
    g3 = Goal.create(:title => "goal 3")
    a1 = Activity.create(:title => "3333")
    a2 = Activity.create(:title => "4444")
    a3 = Activity.create(:title => "555")
    g3.activities << a1
    c2.activities << a2
    c2.activities << a3
    c2.goals << g3
    s.chapters << c2
    stratact = Activity.create(:title => "stratact")
    s.activities << stratact
    s
  end

def print
  puts "title:" + self.title
  puts "user: #{self.user_id}"
end
  
end
