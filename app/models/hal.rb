class Hal < ActiveRecord::Base
  acts_as_paranoid
  default_scope order("created_at DESC")
  include ActionLogging
  scope :private, -> { where(privacy: 0) }
  scope :not_private, -> { where("privacy <> 0") }
  scope :public, -> { where(privacy: 1) }

  belongs_to :user
  belongs_to :course
  belongs_to :halable, :polymorphic => true
  belongs_to :fromable, :polymorphic => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  attr_accessible :entry, :privacy, :halable, :help, :insights, :user_id, :fromable, :course_id, :halable_id, :halable_type, :tag_list
  acts_as_taggable
  
  validates_presence_of :entry

  
  # text used for updates
  def text
    self.entry
  end
  
  def private?
    self.privacy == 0
  end
  def public?
    self.privacy == 1
  end
  
  def add_comment(comment)
    self.comments << comment
  end
  
  def delete_comment(comment)
    self.comments.destroy(comment)
  end
  
  # find all hals where help has been requested
  #  TODO later sort by date and proximity to user
  def self.help_wanted
     Hal.where(:help => true).public.order("created_at desc")
  end
  
  def get_all_comments
    self.comments
  end

  # make hal about item (set halable, from and course information based on item)
  def hal_about(item)
    self.halable = item
    self.fromable = item.from
    self.course_id = item.course_id    
    # item.hals << self
  end
  
  # get all hals related to an item (hals about items that have the same "from")
  def self.get_related_hals(halable, limit = 0)
    if (halable.from_id)
      # Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.from_id = ? ", 3])
      Hal.where("((fromable_id = ? and fromable_type = ?) or (halable_id = ? and halable_type = ?)) and user_id <> ?", halable.from_id, halable.class.name, halable.from_id, halable.class.name, halable.user_id)
       # self.where(:halable_type => halable.class.name, :) halable.from.
    else#   TODO
      Hal.where("((fromable_id = ? and fromable_type = ?) or (halable_id = ? and halable_type = ?)) and user_id <> ?", halable.id, halable.class.name, halable.id, halable.class.name, halable.user_id)
      # halable.hals
    end    
    
  end

  # get all hals related to an item (hals about items that have the same "from")
  def self.get_related_and_self_hals(halable, limit = 0)
    if (halable.from_id)
      #  TODO HACK remote hardcoded Activity
      # Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.from_id = ? ", 3])
      Hal.where("((fromable_id = ? and (fromable_type = ? or fromable_type = 'Activity')) or (halable_id = ? and halable_type = ?))", halable.from_id, halable.class.name, halable.from_id, halable.class.name).limit(limit)
       # self.where(:halable_type => halable.class.name, :) halable.from.
    else#   TODO
      Hal.where("((fromable_id = ? and fromable_type = ?) or (halable_id = ? and halable_type = ?))", halable.id, halable.class.name, halable.id, halable.class.name).limit(limit)
      # halable.hals
    end    
    
  end
  
  
  # TODO 
  def self.get_hals_related_to_strategy(strategy)
    []
    # [Hal.last]
    # get all from_ids of activities in strategy
    # get all course_ids of activities in strategy
    # get set of hals about those list
  end
  
  # format post of this hal for FB (for now)
  def post_print(url)
    post = "I just wrote this post at #{url}:\n #{entry}"
    post += insights ? "\n<strong>insights</strong>: #{insights}" : ""    
  end
  
  def print
    com = ', comments: '
    self.comments.each {|comment| com+="id:#{comment.id}, body: #{comment.body}"}
    puts "Hal id: #{id} entry: #{entry}, insights: #{insights} help: #{help}#{com}"
  end
  
  def log_create
    ActionLog.log_create(self) if self.privacy != 0
  end
  
  def log_destroy
    ActionLog.log_destroy(self) if self.privacy != 0
  end
  
  def log_update
    ActionLog.log_update(self) if self.privacy != 0
  end
  
end
