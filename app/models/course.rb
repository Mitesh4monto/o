class Course < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  
  has_one :strategy, class_name: CourseStrategy #, :foreign_key => 'course_id'
  belongs_to :user
  
  has_many :users, :foreign_key => 'following_course_id'
  has_many :hals, :foreign_key => 'course_id'

  has_many :user_strategies, class_name: Strategy, :foreign_key => 'course_id'

  attr_accessible :name,
                  :user_id,
                  :course_strategy_id,
                  :description,
                  :overview,
                  :about_the_author,
                  :published
                  
    after_create :create_strategy   


  # create strategy object for course after create
  def create_strategy
    CourseStrategy.create(:user_id => self.user_id, :course_id => self.id)
  end

  
  # create a course based on a user strategy
  def self.create_from_strategy(strategy)
    c = Course.create
    #hack
    strat = strategy.amoeba_dup
    strat.type = "CourseStrategy"
    strat.save
    c.course_strategy = CourseStrategy.find(strat.id)
    c.user = strategy.user
    c.save
    c
  end
  
  # TODO checks and whatnot  !!!!  spec
  def add_user_to_course(user)
    user.add_to_my_strategy(self.strategy)
    self.users << user
    user.save
  end
  
  # true for now
  def get_number_people_following
    self.get_course_followers.size
     # Activity.where(:course_id => self.id).select("distinct(user_id)").size
  end

  # true for now
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

end
