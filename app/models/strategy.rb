class Strategy < ActiveRecord::Base
  has_many :activities, :as => :activityable, :dependent => :destroy 
  has_many :goals, :as => :goalable, :dependent => :destroy 
  has_many :chapters, :dependent => :destroy 

  has_many :hals, :as => :halable #, :dependent => :destroy

  belongs_to :user
  belongs_to :from_course, class_name: Course, :foreign_key => 'course_id'
  
  amoeba do
    enable
    prepend :title => "Copy of "
    exclude_field :hals
  end
  
  
  
  def add_activity(activity)
    self.activities << activity
  end
  
  def chapters()
    self.chapters
  end
  
  # remove an activity from a strategy
  def delete_activity(activity)    
    self.activities.destroy(activity)
  end
  
  
  def self.c    
    s = Strategy.create(:title => "foo")
    a1 = Activity.create(:title => "main chap act")
    s.main_chapter.activities << a1    
    
    g = Goal.create(:title => "important")
    g2 = Goal.create(:title => "not very")
    
    c1 = Chapter.create(:title => "aaaaa")    
    a1 = Activity.create(:title => "1111", :goal_id => g.id)
    a2 = Activity.create(:title => "2222", :goal_id => g2.id)
    c1.activities << a1
    c1.activities << a2
    s.chapters << c1
    
    c2 = Chapter.create(:title => "bbbb")
    a1 = Activity.create(:title => "3333", :goal_id => g.id)
    a2 = Activity.create(:title => "4444", :goal_id => g.id)
    a3 = Activity.create(:title => "555", :goal_id => g.id)
    c2.activities << a1
    c2.activities << a2
    c2.activities << a3
    s.chapters << c2
    s
  end

def print
  puts "title:" + self.title
  puts "user: #{self.user_id}"
end
  
end
