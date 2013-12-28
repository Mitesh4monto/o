class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :following_course_id, :provider, :uid, :first_name, :last_name
  has_one :strategy, :class_name => "UserStrategy" 
  after_create :create_strategy
  has_many :courses
  has_many :goals
  has_many :hals
  has_many :comments 
  has_many :activities
  has_many :chapters
  belongs_to :following_course, :class_name => "Course", :foreign_key => 'following_course_id'
  # following_course, class_name: Course

  has_and_belongs_to_many(:following, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_a_id", :association_foreign_key => "user_b_id")
  has_and_belongs_to_many(:followers, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_b_id", :association_foreign_key => "user_a_id")

  attr_accessible :avatar
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  
  def create_strategy
    UserStrategy.create(:user_id => self.id, :title => "Strating strategy")
  end
  
  def self.new_with_session(params, session)
     super.tap do |user|
       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
       end
     end
   end
   
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
  # get all hals users followed by user
  def find_following_hals
      Hal.where("user_id in (?)", self.following.collect(&:id)).order("created_at desc")
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

  # TODO add rspec
  # add all the activities from a strategy (user or course) into user's strategy
  def add_to_my_strategy(strategy)
    strategy.activities.each do |activity|
      if (!self.strategy.contains_activity(activity))
        # not currently in strategy => add it
        copied_activity = activity.amoeba_dup
        copied_activity.user_id = self.strategy.user.id        
        self.strategy.activities << copied_activity
      end
    end
    self.strategy.save
  end

  
  # get list of courses user has activities from     TODO add rspec for this
  def get_courses_in_list
    courses = []
    # go through each activity and if it's from a course add it to list
    self.strategy.activities.each do |activity|
    course_id = Activity.find(activity.from_id).get_course_id
      if (course_id && !courses.include?(course_id))
        courses << course_id
      end
    end
    return courses
  end
  
  
  def print
    puts "User: id #{self.id}, name: #{self.name}"
  end

end
