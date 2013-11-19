class Course < ActiveRecord::Base
  has_one :course_strategy
  belongs_to :user

  attr_accessible :name,
                  :user_id,
                  :strategy,
                  :description,
                  :about_the_author
                  
<<<<<<< HEAD

  
  # create a course based on a strategy
  def self.create_course_from_strategy(strategy)
    c = Course.create
    strat = strategy.amoeba_dup
    strat.becomes!(CourseStrategy)
    puts strat.type
    strat.save
    puts strat.type
=======
  
  # create a course based on a strategy
  def self.create_from_strategy(strategy)
    c = Course.create
    strat = strategy.amoeba_dup
    strat.type = "CourseStrategy"
    strat.save
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39
    c.course_strategy = strat
    c.user = strategy.user
    c.save
    c
  end
  
<<<<<<< HEAD
  # TODO checks and whatnot
  def add_user_to_course(user)
    user.replace_strategy_with_template(self.strategy)
    user.following_course = self
  end

=======
  def create_user_strategy(user)
    strat = self.strategy.amoeba_dup
    user.strategy.destroy    
    user.strategy = strat
    strat.save
  end
>>>>>>> dcc05d65dd23d3e8b8d3ce2b4b9cd344c9073a39
  
  
end
