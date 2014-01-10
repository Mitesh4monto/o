class Hal < ActiveRecord::Base
  scope :private, -> { where(privacy: 0) }
  scope :not_private, -> { where("privacy <> 0") }
  scope :public, -> { where(privacy: 1) }

  belongs_to :user
  belongs_to :course
  belongs_to :halable, :polymorphic => true
  belongs_to :fromable, :polymorphic => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  attr_accessible :entry, :privacy, :halable, :help, :insights, :user_id, :fromable, :course_id, :halable_id, :halable_type
  

  def add_comment(comment)
    self.comments << comment
  end
  
  def delete_comment(comment)
    self.comments.destroy(comment)
  end
  
  def self.help_wanted
     Hal.where(:help => true).order("created_at desc")
  end
  
  def get_all_comments
    self.comments
  end

  def hal_about(item)
    self.halable = item
    puts item.id
    self.fromable = item.from    
    self.course_id = item.get_course_id    
  end
  
  def self.get_related_hals(halable)
    if (halable.from_id)
      # Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.from_id = ? ", 3])
      Hal.where("(fromable_id = ? and fromable_type = ?) or (halable_id = ? and halable_type = ?)", halable.from_id, halable.class.name, halable.from_id, halable.class.name)
       # self.where(:halable_type => halable.class.name, :) halable.from.
    else  
      []
      # halable.hals
    end    
    
  end
  
  
  def halable_activity
    self.halable.id if self.halable.is_a? Activity
  end  
  
  # TODO 
  def self.get_hals_related_to_strategy(strategy)
    []
    # [Hal.last]
    # get all from_ids of activities in strategy
    # get all course_ids of activities in strategy
    # get set of hals about those list
  end
  
  
  def print
    com = ', comments: '
    self.comments.each {|comment| com+="id:#{comment.id}, body: #{comment.body}"}
    puts "Hal id: #{id} entry: #{entry}, insights: #{insights} help: #{help}#{com}"
  end
  
end
