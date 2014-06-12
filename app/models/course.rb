class Course < ActiveRecord::Base
  require 'will_paginate'
  include ActionLogging
  LOGUPDATE = true

  # search functionality
  include PgSearch
  multisearchable :against => [:name, :description, :overview, :about_the_author]
  pg_search_scope :full_course_search, 
    :against => [[:name, 'A'],[ :description, 'B'],[ :overview, 'B'],[ :about_the_author, 'B']],
    using: {tsearch: {dictionary: "english"}},
    :associated_against => {
      :activities => [[:title, 'C'],[  :description, 'C'],[  :timing_expression, 'C']],
      :activity_in_sequences => [[:title, 'C'],[:description, 'C'],[:timing_expression, 'C']],
      :goals => [[:title, 'B']],
  }
  
  has_many :activity_in_sequences, :through => :strategy
  has_many :activities, :through => :strategy
  has_many :goals, :through => :strategy


    
  # everyone's goals copied...?
  has_many :goals
  
  acts_as_paranoid
  UNPUBLISHED = 0
  PUBLISHED = 1
  LISTED = 2
  scope :unpublished, -> { where(status: UNPUBLISHED) }
  scope :published, -> { where(status: PUBLISHED) }
  scope :listed, -> { where(status: LISTED) }

  
  has_one :strategy, class_name: CourseStrategy, :dependent => :destroy
  belongs_to :user
  
  has_many :hals, :foreign_key => 'course_id'
  
  has_many :user_strategies, class_name: Strategy, :foreign_key => 'course_id'

  attr_accessible :name,
                  :user_id,
                  :course_strategy_id,
                  :description,
                  :overview,
                  :about_the_author,
                  :status,
                  :external_site,
                  :course_image, 
                  :tag_list
     has_attached_file :course_image, :styles => { :medium => "200x200#", :thumb => "100x100#" }
     # , :default_url => "https://s3-us-west-2.amazonaws.com/melearning/courses/course_images/000/000/078/medium/hawk.png"

  acts_as_taggable
                  
  validates_presence_of :name, :overview

  after_create :create_strategy


  # text used for updates
  def text
    self.name + " -- " + self.overview
  end
  
  # return true if there is at least one customization in the course
  # currently on activities only
  def has_customizations?
    self.strategy.current_activities.each do |activity|
      return true if activity.customization and !activity.customization.empty?
    end
    return false
  end
  
  def published?    
    self.status >= PUBLISHED
  end
  
  def listed?
    self.status == LISTED
  end
  
  # publish a course => set status
  def publish
    self.status = PUBLISHED
  end

  # list a course => set status
  def list
    self.status = LISTED
  end
  # unlist a course => set status
  def unlist
    self.status = PUBLISHED
  end


  # Any reasons why course can't be published here
  def publishable?
      self.strategy.current_activities.size > 0
  end

  # create strategy object for course after create
  def create_strategy
    CourseStrategy.create(:user_id => self.user_id, :course_id => self.id)
  end

  def add_activity(activity)
    activity.course_id = self.id;    
    self.strategy.activities << activity      
  end
  
  # TODO checks and whatnot  !!!!  spec
  def add_user_to_course(user)
    user.add_to_my_strategy(self.strategy)
    user.save
  end
  
  # true for now
  # total number of people who have activities from this course
  def get_number_people_following
    self.get_course_followers.size
     # Activity.where(:course_id => self.id).select("distinct(user_id)").size
  end

  # true for now  -- get all users enrolled in a course
  #  definiton of enrolled in a course is any user that has an activity in their strategy that's in this course or was
  def get_course_followers
    User.find_by_sql(["select * from users where id in (select distinct(user_id) from activities where course_id = ?)", self.id])
  end


  # true for now
  def self.get_number_people_following_published_courses
    # results = ActiveRecord::Base.connection.execute("select count(distinct(a.user_id)), 
    #       c.id as course from activities a, courses c where c.published=true and c.id = a.course_id group by c.id").to_set
    results = ActiveRecord::Base.connection.execute("select count(distinct(user_id)), course_id  from activities where course_id is not null group by course_id").to_set
    return_set = {}
    results.each do |result|      
      return_set[result["course_id"]] = result["count"]
    end
    return return_set
  end
  
  def post_print
    post = "New course on miaou I wrote. Everyone join!:\n #{name}"
    post += "\ndescription: #{ ActionController::Base.helpers.strip_tags(description)}" 
  end
  
  # used for command line adding activities in a course
  def add_activities_strings(acts, goal_text = nil)
    descr = '<strong>Highlight 1</strong>.<br><strong>Highlight 2</strong>.<br>Details/Exercise.<br><BR>  For more information refer to book.'
    goal_id = nil
    goal_id = self.strategy.create_or_use_goal(goal_text).id if goal_text
    acts.each do |act| 
      self.add_activity(Activity.create!(:user_id => self.user_id, :title => act, :description => descr, :kind_of_timing => 'Other', :goal_id => goal_id))
    end
  end

end
