class Chapter < ActiveRecord::Base
  acts_as_orderable
  belongs_to :strategy
  has_many :activities, :as => :activityable, :dependent => :destroy 
  has_many :goals, :as => :goalable, :dependent => :destroy 
  has_many :hals, :as => :halable
  
  amoeba do
    enable
    nullify :user_id
    nullify :strategy_id
    prepend :title => "Copy of "
    prepend :description => "Copy of "
    exclude_field :hals
    # set from template as original's from, or directly to original
    customize(
      lambda do |original_chapter,new_chapter|
        if original_chapter.from_id then
          new_chapter.from_id = original_chapter.from_id
        else 
          new_chapter.from_id = original_chapter.id
        end
      end
    )
  end

  # returns all hals that have the same from template
  def get_related_hals
    if (self.from_id) then
      Hal.find(:all, :joins => "left join chapters on chapters.id=hals.halable_id", :conditions => ["activities.id = ? or (chapters.from_id = ? and chapters.id != ?)", self.from_id, self.from_id, self.id])
    else  
      return []
    end    
  end
  
  def hal_about(hal)
    self.hals << hal
  end

  
  def get_activities
    self.activities
  end

  def add_activity(activity)
    self.activities << activity
  end
  
  def delete_activity(activity)
    self.activities.destroy(activity)
  end

  def get_goals
    self.goals
  end

  def add_goal(goal)
    self.goals << goal
  end
  
  def delete_goal(goal)
    self.goals.destroy(goal)
  end  
  
  def make_copy
    c = self.amoeba_dup
    c.save
    c
  end
  
end
