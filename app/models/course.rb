class Course < ActiveRecord::Base
  has_one :strategy
  belongs_to :user
  
  def self.create_from_strategy(strategy)
    c = Course.new
    c.user = strategy.user
    c.strategy = strategy.amoeba_dup
    c.save
    c
  end
  
end
