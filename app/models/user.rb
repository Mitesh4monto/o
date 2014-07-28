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
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :following_course_id, :provider, :uid, :first_name, :last_name, :oauth_expires_at, :oauth_token, :unconfirmed_email, :confirmed_at, :about_me
  has_one :strategy, :class_name => "UserStrategy" 
  after_create :create_strategy
  has_many :courses
  has_many :goals
  has_many :hals
  has_many :comments 
  has_many :commitment_marks
  has_many :activities
  has_many :chapters
  belongs_to :following_course, :class_name => "Course", :foreign_key => 'following_course_id'
  # following_course, class_name: Course

  has_many :action_logs


  has_and_belongs_to_many(:following, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_a_id", :association_foreign_key => "user_b_id")
  has_and_belongs_to_many(:followers, :class_name => "User", :join_table => "user_followings", :foreign_key => "user_b_id", :association_foreign_key => "user_a_id")

  attr_accessible :avatar
    has_attached_file :avatar, :styles => { :large => "200x200#", :medium => "150x150#", :small => "100x100#", :thumb => "50x50#", :mini => "30x30#" }, :default_url => "/images/:style/anonymousUser.jpg"
  
  # add user to list of following
  def follow(user)
    self.following << user
    ActionLog.log_other(self.id, "follow", user)     
  end
  
  # removes user to list of following
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
   
   # if user doesn't exist, fetch info from fb and create user
   def self.from_omniauth(auth)
     puts("from omni")          
     # where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
     # logger.info("received from Facebook: #{auth.to_yaml}")
     @graph = Koala::Facebook::API.new(auth.credentials.token)
     friends = @graph.get_connections("me", "friends")
     # logger.info("friends: #{friends.to_yaml}")
     profile = @graph.get_object("me")
     
       user = User.where(:provider => auth.provider, :uid => auth.uid).first       
       puts user.to_yaml if user
       puts 'no user' unless user
       unless user         
         @graph = Koala::Facebook::API.new(auth.credentials.token)
         profile = @graph.get_object("me")
         puts "me: #{profile.to_yaml}"
         # logger.info("user: #{user.to_yaml}")

         puts "received from Facebook: #{auth.to_yaml}"
         # logger.info("received from Facebook: #{auth.info.image}")
         user = User.new(name:auth.info.name,
                            provider:auth.provider,
                            oauth_token:auth.credentials.token,
                            uid:auth.uid,
                            provider:auth.provider,
                            email:auth.info.email,
                            oauth_expires_at:Time.at(auth.credentials.expires_at),
                            password:Devise.friendly_token[0,20]
                            )
        user.skip_confirmation!
        
        begin
          user.save!
          puts "user saved id #{user.id}"
          user.avatar = open(auth.info.image)
          logger.info("adding avatar from #{auth.info.image}")
          user.save
        rescue Exception => e  
          logger.info("deescalated quickly... #{e.message}  ")
        end
          logger.info("post exception")          
      end
      user
   end 
   
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    logger.info("received from Facebook: #{auth.inspect}")
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
      user.skip_confirmation! 
      user.save
    end
    user
  end
  
  # get all hals users followed by user
  def find_following_hals
      Hal.where("user_id in (?)", self.following.collect(&:id)).public.order("created_at desc")
  end
    
  def find_course_hals
    Hal.where("course_id in (?)", self.get_following_courses.collect(&:id)).public.order("created_at desc")    
  end
  
  # TODO add rspec
  # add all the activities from a course strategy into user's strategy
  def add_to_my_strategy(strategy)
    puts 'add to my strat'
    puts self.to_yaml
    # copy all activities
    strategy.activities.each do |activity|
      if (!self.strategy.contains_activity(activity))
          self.strategy.activities << activity.copy_to_user(self)
      end
    end
    
    # copy all activitysequences
    strategy.activity_sequences.each do |activity_sequence|
      if (!self.strategy.contains_activity_sequence(activity_sequence))
        as = activity_sequence.copy_to_user(self)
      end
    end
    
    self.strategy.save
    # log action
    ActionLog.log_other(self.id, "join", strategy.course) 
  end

  
  #  TODO cleanup/optimize if many courses per person
  # get list of courses user has activities from     TODO add rspec for this
  def get_following_courses
     Course.find_all_by_id(self.strategy.activities.pluck(:course_id).uniq.compact)
  end
  
  
  def print
    puts "User: id #{self.id}, name: #{self.name}"
  end

end
