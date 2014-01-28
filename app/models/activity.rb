require 'chronic'

class Activity < ActiveRecord::Base
  include ActionLogging
  has_many :action_logs, :as => :loggable, :dependent => :destroy
  acts_as_paranoid
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

  attr_accessible :from_id, :user_id, :title, :description, :course_id, :timing_expression, :timing_duration, :kind_of_timing, :customization, :strategy_id, :freak_number, :freak_interval, :reactive_expression, :until_radio
  attr_writer :freak_number, :freak_interval, :reactive_expression, :until_radio
  
  validates :title, :presence => {:message => "no blanky"}
  # validate :validate_timing   TODO uncomment -- ONLY FOR TESTING

  belongs_to :from, class_name: Activity, :foreign_key => 'from_id'
  has_many :copied_activities, class_name: Activity, :foreign_key => 'from_id'
  
  before_save :create_timing
  
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
  
  def reactive_expression
      @reactive_expression.nil? ? timing_expression : @reactive_expression
  end

  def until_radio  
    self.timing_duration.blank? ? "nodate" : "date"
  end
  
  def create_timing
    self.timing_expression = @freak_number + " " + @freak_interval if @freak_number.present?
    self.timing_expression = @reactive_expression if @reactive_expression.present?
    self.timing_duration = "" if @until_radio == "nodate"
    self.timing_duration = timing_duration if @until_radio == "date"  # necess?
  end
  
  # ensure until date is 
  def validate_timing
    if @until_radio == "date" && Chronic.parse(self.timing_duration).nil?
        errors.add(:timing_duration, "you need a valid date")
    end
    if self.kind_of_timing == "Frequency" && @freak_number.blank?
      errors.add(:freak_number, "how often?")
    end
  end
  
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
