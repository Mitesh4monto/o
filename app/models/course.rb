class Course < ActiveRecord::Base
  belongs_to :course_strategy, class_name: CourseStrategy, :foreign_key => 'course_strategy_id'
  belongs_to :user
  
  has_many :users, :foreign_key => 'following_course_id'

  has_many :user_strategies, class_name: Strategy, :foreign_key => 'course_id'

  attr_accessible :name,
                  :user_id,
                  :course_strategy_id,
                  :description,
                  :about_the_author
                  
    after_create :create_strategy


  # create strategy object for course after create
  def create_strategy
    self.course_strategy = CourseStrategy.create(:title => "strategy of course #{self.name}")
    self.save
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
    user.replace_strategy_with_template(self.course_strategy)
    self.users << user
    user.save
  end

end
