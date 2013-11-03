class Strategy < ActiveRecord::Base
  belongs_to :course
  has_many :ordered_chapters, :dependent => :destroy 
  has_one :main_chapter
  belongs_to :user
  
  after_create :create_main_chapter

  amoeba do
    enable
    prepend :title => "Copy of "
  end
  
  # After creation of strategy add main chapter
  def create_main_chapter
    MainChapter.create(:strategy_id => self.id)
  end
  
  # add an activity to a strategy (adds it to main chapter)
  #  def add_activity(activity, chapter)
  def add_activity(activity)
    self.get_main_chapter.activities << activity
  end
  
  # remove an activity from a strategy (removes from main chapter)
  def delete_activity(activity)    
    self.get_main_chapter.activities.delete(activity)
  end
  
  def self.c
    s = Strategy.create(:title => "foo")
    a1 = Activity.create(:title => "main chap act")
    s.get_main_chapter.activities << a1
    
    c1 = Chapter.create(:title => "aaaaa")    
    a1 = Activity.create(:title => "1111")
    a2 = Activity.create(:title => "2222")
    c1.activities << a1
    c1.activities << a2
    s.chapters << c1
    
    c2 = Chapter.create(:title => "bbbb")
    a1 = Activity.create(:title => "3333")
    a2 = Activity.create(:title => "4444")
    a3 = Activity.create(:title => "555")
    c2.activities << a1
    c2.activities << a2
    c2.activities << a3
    s.chapters << c2
    s
  end

  
end
