class Strategy < ActiveRecord::Base
  has_many :hals, :as => :halable #, :dependent => :destroy
  belongs_to :course
  has_many :ordered_chapters, :dependent => :destroy 
  has_one :main_chapter
  belongs_to :user
  
  after_create :create_main_chapter

  amoeba do
    enable
    prepend :title => "Copy of "
    exclude_field :hals
  end
  
  # After creation of strategy add main chapter
  def create_main_chapter
    MainChapter.create(:strategy_id => self.id)
  end
  
  # add an activity to a strategy (adds it to main chapter)
  #  def add_activity(activity, chapter)
  def add_activity(activity)
    self.main_chapter.activities << activity
  end
  
  def chapters()
    self.ordered_chapters
  end
  
  # remove an activity from a strategy (removes from main chapter)
  def delete_activity(activity)    
    self.main_chapter.activities.destroy(activity)
  end
  
  def self.c
    s = Strategy.create(:title => "foo")
    a1 = Activity.create(:title => "main chap act")
    s.main_chapter.activities << a1
    
    g = Goal.create(:title => "important")
    g2 = Goal.create(:title => "not very")
    
    c1 = OrderedChapter.create(:title => "aaaaa")    
    a1 = Activity.create(:title => "1111", :goal_id => g.id)
    a2 = Activity.create(:title => "2222", :goal_id => g2.id)
    c1.activities << a1
    c1.activities << a2
    s.chapters << c1
    
    c2 = OrderedChapter.create(:title => "bbbb")
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
  puts "main chapter: #{self.main_chapter.print}"
  puts "user: #{self.user_id}"
end
  
end
