class Course < ActiveRecord::Base
  has_one :course_strategy
  belongs_to :user

  attr_accessible :name,
                  :user_id,
                  :strategy,
                  :description,
                  :about_the_author
                  

  
  # create a course based on a strategy
  def self.create_course_from_strategy(strategy)
    c = Course.create
    strat = strategy.amoeba_dup
    strat.becomes!(CourseStrategy)
    puts strat.type
    strat.save
    puts strat.type
    c.course_strategy = strat
    c.user = strategy.user
    c.save
    c
  end
  
  # TODO checks and whatnot
  def add_user_to_course(user)
    user.replace_strategy_with_template(self.strategy)
    user.following_course = self
  end

  
  
end
