class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :following_course_id
  has_one :strategy
  after_create :create_strategy
  has_many :courses
  has_many :goals
  has_many :hals
  has_one :following_course, class_name: Course

  
  def create_strategy
    Strategy.create(:user_id => self.id, :title => "You strat")
  end
  
  #  todo add if strategy is template?
  # for copying someone's strat?
  def replace_strategy_with_template(strategy)
    s = self.strategy
    self.strategy = strategy.dup
    self.strategy.type = "Strategy"
    self.strategy.save
    s.destroy
  end
  
  
  def print
    puts "User: id #{self.id}, name: #{self.name}"
  end

end
