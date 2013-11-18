class Course < ActiveRecord::Base
  has_one :course_strategy
  belongs_to :user

  attr_accessible :name,
                  :user_id,
                  :strategy,
                  :description,
                  :about_the_author
                  
  
  # create a course based on a strategy
  def self.create_from_strategy(strategy)
    c = Course.create
    strat = strategy.amoeba_dup
    strat.type = "CourseStrategy"
    strat.save
    c.course_strategy = strat
    c.user = strategy.user
    c.save
    c
  end
  
  def create_user_strategy(user)
    strat = self.strategy.amoeba_dup
    user.strategy.destroy    
    user.strategy = strat
    strat.save
  end
  
  
end
