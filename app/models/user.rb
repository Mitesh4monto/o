class User < ActiveRecord::Base
  has_one :strategy
  after_create :create_strategy
  has_many :courses
  
  def create_strategy
    Strategy.create(:strategy_id => self.id, :title => "You strat")
  end
  
  #  todo add if strategy is template?
  def replace_strategy_with_template(strategy)
    s = self.strategy
    self.strategy = strategy.dup    
    self.strategy.save
    s.destroy
  end

end
