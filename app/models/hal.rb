class Hal < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :halable, :polymorphic => true
  belongs_to :fromable, :polymorphic => true
  has_many :comments, :as => :commentable, :dependent => :destroy

  def add_comment(comment)
    self.comments << comment
  end
  
  def delete_comment(comment)
    self.comments.destroy(comment)
  end
  
  def get_all_comments
    self.comments
  end
  
  # todo pass hal?
  def self.hal_about(item, user, entry, insights = nil, help = false)
    h = Hal.create(:user => user, :entry => entry, :insights => insights, :help => help, :course_id => user.following_course_id)
    h.halable = item
    h.fromable = item.get_hierarchical_from
    h.save
    h
  end
  
  def self.get_related_hals(halable)
    if (halable.from_id)
      Hal.find(:all, :joins => "left join activities on activities.id=hals.halable_id", :conditions => ["activities.from_id = ? ", 3])
       # self.where(:halable_type => halable.class.name, :) halable.from.
    else  
      # halable.hals
    end    
    
  end
  
  # TODO 
  def self.get_hals_related_to_strategy(strategy)
    [Hal.last]
    # get all from_ids of activities in strategy
    # get set of hals about that list
  end
  
  
  def print
    com = ', comments: '
    self.comments.each {|comment| com+="id:#{comment.id}, body: #{comment.body}"}
    puts "Hal id: #{id} entry: #{entry}, insights: #{insights} help: #{help}#{com}"
  end
  
end
