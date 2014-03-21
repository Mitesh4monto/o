require 'chronic'

class Activity < ActiveRecord::Base
  include ActionLogging
  acts_as_paranoid
  acts_as_taggable
  default_scope order('position')
   
  has_many :commitment_marks, :as => :cmable, :dependent => :destroy
  has_many :hals, :as => :halable 
  has_many :from_template_hals, :as => :halable 
  has_many :comments, :as => :commentable, :dependent => :destroy
  # belongs_to :activityable, :polymorphic => true  
  belongs_to :user
  belongs_to :goal
  belongs_to :course

  belongs_to :strategy
  acts_as_list scope: :strategy

  attr_accessible :from_id, :user_id, :title, :goal_text, :description, :course_id, :timing_expression, :timing_duration, :kind_of_timing, :customization, :strategy_id, :freak_number, :freak_interval, :reactive_expression, :until_radio, :tag_list, :goal_id, :new_goal_text, :duration_number, :duration_unit, :timing_until
  attr_accessor :new_goal_text
  attr_writer :freak_number, :freak_interval, :reactive_expression, :until_radio, :duration_number, :duration_unit
  
  validates :title, :presence => {:message => "no blanky"}
  # validate :validate_timing   #TODO uncomment -- ONLY FOR TESTING

  belongs_to :from, class_name: Activity, :foreign_key => 'from_id'
  has_many :copied_activities, class_name: Activity, :foreign_key => 'from_id'
  
  before_save :create_timing

  def log_destroy
    # if (self.strategy and self.strategy.class.name == "CourseStrategy")
    #   ActionLog.log_other(self.user_id, "update", self.strategy.course)  if self.strategy.course.published?
    # else
    #   ActionLog.log_destroy(self)             
    # end    
  end

  def log_create
    # if (self.strategy and self.strategy.class.name == "CourseStrategy")
    #   ActionLog.log_other(self.user_id, "create", self.strategy.course)  if self.strategy.course.published?
    #   # don't log if it's in a course or from a course (copy)
    # elsif (self.strategy.class.name != "CourseStrategy" and !self.course_id)  
    #   ActionLog.log_create(self)             
    # end    
  end

  def log_update
    # if (self.strategy and self.strategy.class.name == "CourseStrategy")
    #   ActionLog.log_other(self.user_id, "update", self.strategy.course)  if self.strategy.course.published?
    # else
    #   ActionLog.log_update(self)             
    # end    
  end
  
  # text used for updates
  def text
    self.title + " -- " + self.description
  end
  
  # is this act in a course?
  def course_activity?
    self.strategy.class.name == "CourseStrategy"
  end
  
  # Is act in user plan?
  def myp_activity?
    self.strategy.class.name == "UserStrategy"    
  end
  
  # first part of the timing expression in the db
  def freak_number
    expr = timing_expression.blank? ? "" : timing_expression.split.first
    @freak_number.nil? ? expr : @freak_number
  end
  
  # second part of the timing expression in the db
  def freak_interval
    expr = timing_expression.blank? ? "" : timing_expression.split.last
    @freak_interval.nil? ? expr : @freak_interval
  end

  # first part of the timing expression in the db
  def duration_number
    expr = self.timing_duration.blank? ? "" : self.timing_duration.split.first
    @duration_number.nil? ? expr : @duration_number
  end
  
  # second part of the timing expression in the db
  def duration_unit
    expr = self.timing_duration.blank? ? "" : self.timing_duration.split.last
    @duration_unit.nil? ? expr : @duration_unit
  end
  
  def reactive_expression
      @reactive_expression.nil? ? timing_expression : @reactive_expression
  end

  def until_radio  
    self.timing_duration.blank? ? "nodate" : "date"
  end
  
  # before_save -- store the timing expression and duration based on different form fields
  def create_timing
    if @freak_number.present?
      self.timing_expression = @freak_number + " " + @freak_interval
    elsif @reactive_expression.present?
      self.timing_expression = @reactive_expression
    end
    self.timing_duration = "" if @until_radio == "nodate"
    self.timing_duration = @duration_number + " " + @duration_unit if @until_radio == "date" and self.timing_until.blank?
  end
  
  # ensure until date is 
  def validate_timing
    v = Float(@duration_number) rescue false
    puts "v = #{v}"
    if @until_radio == "date" && !(Float(@duration_number) rescue false)
        errors.add(:timing_duration, "you need a duration")
    end
    if self.kind_of_timing == "Frequency" && @freak_number.blank?
      errors.add(:freak_number, "how often?")
    end
  end
  
  # add this activity to a user's strategy
  def copy_to_user(user)
    activity = self.dup
    activity.title = self.title
    activity.user_id = user.id
    # point to original (self or self's from)
    if (self.from_id)
      activity.from_id = self.from_id
    else
      activity.from_id = self.id
    end
    if (!self.timing_duration.blank?)
      activity.timing_until = eval(self.timing_duration.split.first + "." + self.timing_duration.split.last.downcase + ".from_now")
      puts activity.timing_until
    end
    activity.strategy_id = user.strategy.id
    activity.course_id = self.course_id
    activity.goal = self.goal.copy_to_user(user) if self.goal
    activity.save
    activity
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
  

  # get "from" template for chapter if exists or parent
  def get_hierarchical_from
    if (self.from_id) then
      self.from
    else 
      self.strategy.get_hierarchical_from
    end
  end
  
  # returns all hals that have the same from template
  def related_hals
    Hal.get_related_hals(self)
    # if (self.from_id)
    #   Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.id = ? or (activities.from_id = ? and activities.id != ?)", self.from_id, self.from_id, self.id])
    # else  
    #   return []
    # end    
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
