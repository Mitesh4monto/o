class Course < ActiveRecord::Base
  has_one :strategy
  belongs_to :user
  
  def self.create_from_strategy(strategy)
    c = Course.create
    c.user = strategy.user
    strat = strategy.amoeba_dup
    strat.save
    c.strategy = strat
    c.save
    c
  end
  
end
