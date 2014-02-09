class User < ActiveRecord::Base
  acts_as_paranoid
  validates_presence_of :name
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # devise :omniauthable, :omniauth_providers => [:facebook]
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :following_course_id, :provider, :uid, :first_name, :last_name, :oauth_expires_at, :oauth_token, :unconfirmed_email, :confirmed_at
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

  has_many :action_logs


  has_and_belongs_to_many(:following, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_a_id", :association_foreign_key => "user_b_id")
  has_and_belongs_to_many(:followers, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_b_id", :association_foreign_key => "user_a_id")

  attr_accessible :avatar
    has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "100x100", :thumb => "50x50>" }, :default_url => "/images/:style/anonymousUser.jpg"
  
  
  def follow(user)
    self.following << user
  end
  def unfollow(user)
    self.following.delete(user)
  end
  
  def create_strategy
    UserStrategy.create(:user_id => self.id)
  end
  
  def self.new_with_session(params, session)
     super.tap do |user|
       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
       end
     end
   end
   
   def self.from_omniauth(auth)
     # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
     logger.info("received from Facebook: #{auth.to_yaml}")
     @graph = Koala::Facebook::API.new(auth.credentials.token)
     friends = @graph.get_connections("me", "friends")
     logger.info("friends: #{friends.to_yaml}")
     profile = @graph.get_object("me")
       user = User.where(:provider => auth.provider, :uid => auth.uid).first
       unless user
         @graph = Koala::Facebook::API.new(auth.credentials.token)
         profile = @graph.get_object("me")
         logger.info("me: #{profile.to_yaml}")
         logger.info("user: #{user.to_yaml}")

         logger.info("received from Facebook: #{auth.to_yaml}")
         logger.info("received from Facebook: #{auth.info.image}")
         user = User.create(name:auth.info.name,
                            provider:auth.provider,
                            oauth_token:auth.credentials.token,
                            uid:auth.uid,
                            provider:auth.provider,
                            email:auth.info.email,
                            oauth_expires_at:Time.at(auth.credentials.expires_at),
                            password:Devise.friendly_token[0,20]
                            )
        user.avatar = open(auth.info.image)
        logger.info("adding avatar from #{auth.info.image}")
        user.save
      end
      user
     # end
   end 
   
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    logger.info("received from Facebook: #{auth.inspect}")
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
    
  
  # TODO add rspec
  # add all the activities from a strategy (user or course) into user's strategy
  def add_to_my_strategy(strategy)
    # copy all activities
    strategy.activities.each do |activity|
      if (!self.strategy.contains_activity(activity))
          # not currently in strategy => add it
          copied_activity = activity.amoeba_dup
          copied_activity.user_id = self.strategy.user.id
          #  copy goal
          if activity.goal
            goal = Goal.where(title: activity.goal.title, strategy_id: self.strategy.id, user_id: self.id, course_id: activity.get_course_id).first
            goal ||= Goal.create!(title: activity.goal.title, strategy_id: self.strategy.id, user_id: self.id, course_id: activity.get_course_id) 
            copied_activity.goal = goal
          end
          self.strategy.activities << copied_activity
      end
    end
    
    # copy all activitysequences
    strategy.activity_sequences.each do |activity_sequence|
      if (!self.strategy.contains_activity_sequence(activity_sequence))
        as = activity_sequence.amoeba_dup
        as.from_id = activity_sequence.id
        as.user_id = self.id
        self.strategy.activity_sequences << as
        as.set_to_first
        as.save
      end
    end
    
    self.strategy.save
  end

  
  #  TODO cleanup/optimize if many courses per person
  # get list of courses user has activities from     TODO add rspec for this
  def get_following_courses
     Course.find_all_by_id(self.strategy.activities.pluck(:course_id).uniq.compact)
    # courses = []
    # # go through each activity and if it's from a course add it to list
    # self.strategy.activities.each do |activity|
    # activity = Activity.find_by_id(activity.from_id)
    #   if (activity && !activity.course.nil? && !courses.include?(activity.course))
    #     courses << activity.course if activity.course.nil?
    #   end
    # end
    # return courses
  end
  
  
  def print
    puts "User: id #{self.id}, name: #{self.name}"
  end

end
