class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :following_course_id
  has_one :user_strategy
  after_create :create_strategy
  has_many :courses
  has_many :goals
  has_many :hals
  has_many :activities
  has_many :chapters
  belongs_to :following_course, :class_name => "Course", :foreign_key => 'following_course_id'
  # following_course, class_name: Course
  
  def create_strategy
    UserStrategy.create(:user_id => self.id, :title => "Strating strategy")
  end
  
  #  todo add if strategy is template?
  # for copying someone's strat?
  def replace_strategy_with_template(strategy)
    s = self.strategy
    self.strategy = strategy.amoeba_dup
    self.strategy.type = "Strategy"
    self.strategy.save
    s.destroy
  end
  
  
  def print
    puts "User: id #{self.id}, name: #{self.name}"
  end

end
