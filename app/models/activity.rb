class Activity < ActiveRecord::Base
  require "StrategyElementMethods"
  default_scope order('position')
   
  has_many :commitment_marks, :as => :cmable #, :dependent => :destroy
  has_many :hals, :as => :halable #, :dependent => :destroy
  has_many :from_template_hals, :as => :halable #, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  # belongs_to :activityable, :polymorphic => true  
  belongs_to :user
  belongs_to :goal
  belongs_to :course

  belongs_to :strategy
  # belongs_to :activity_sequence
  acts_as_list scope: :strategy

  attr_accessible :from_id, :user_id, :title, :description, :timing_expression, :timing_duration, :kind_of_timing, :customization, :strategy_id  #, :course_id
  
  validates_presence_of :title

  belongs_to :from, class_name: Activity, :foreign_key => 'from_id'
  has_many :copied_activities, class_name: Activity, :foreign_key => 'from_id'
  
  amoeba do
    enable
    nullify :user_id
    # nullify :chapter_id
    exclude_field :hals    
    exclude_field :from_template_hals
    exclude_field :comments
    exclude_field :copied_activities            
    prepend :title => "Copy of "
    # set from template as original's from, or directly to original
    customize(lambda { |original_post,new_post|
        })
    customize([
      lambda do |original_activity,new_activity|
        if original_activity.from_id == nil then
          new_activity.from_id = original_activity.id
          puts original_activity.id
        end
      end,
      lambda do |original_activity,new_activity| 
        if original_activity.from_id then
          new_activity.from_id = original_activity.from_id
        end
        # if original is within a course, put course info there
        new_activity.course_id = original_activity.get_course_id
      end
    ])
  end


  # coruse this activity belongs to
  # if it's a user's, it should returns the course this activity was copied from if it exists
   # or nil if created from scratch
  def get_course_id
    if (self.strategy.is_a? CourseStrategy) then
      self.strategy.course.id
    elsif (self.from)
      self.from.get_course_id
    else nil
    end
  end
  

  # get strategy this activity is part of
  # def strategy
  #   self.activityable.strategy
  # end

  # add a hal to list of hals for activity
  def hal_about(hal)
    hal.fromable = self.get_hierarchical_from
    self.hals << hal
  end

  # get "from" template for chapter if exists or parent
  def get_hierarchical_from
    if (self.from_id) then
      self.from
    else 
      self.strategy.get_hierarchical_from
    end
  end

  
  # returns all hals that have the same from template
  def get_related_hals
    if (self.from_id)
      Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.id = ? or (activities.from_id = ? and activities.id != ?)", self.from_id, self.from_id, self.id])
    else  
      return []
    end    
  end
  
  
  # duplicate
  def make_copy
    a = self.amoeba_dup
    a.save
    a
  end

  def print    
    puts "Activity  id: #{id}. title:" + self.title
    puts "strat: #{self.strategy_id}" 
    if (self.activityable_id)
      puts "#{self.activityable_type}: #{self.activityable.title}"
    end    
    puts "from_id: #{self.from_id}, timing: #{self.kind_of_timing}, #{self.timing_expression}"
    puts "Hals:"
    self.hals.each {|hal| hal.print}
  end

end
