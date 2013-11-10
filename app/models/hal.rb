class Hal < ActiveRecord::Base
  belongs_to :user
  belongs_to :halable, :polymorphic => true
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
  
  def self.hal_about(item, user, entry, insights = nil, help = false)
    h = Hal.create(:user => user, :entry => entry, :insights => insights, :help => help)
    h.halable = item
    h.save
    h
  end
  
  def print
    com = ', comments: '
    self.comments.each {|comment| com+="id:#{comment.id}, body: #{comment.body}"}
    puts "Hal id: #{id} entry: #{entry}, insights: #{insights} help: #{help}#{com}"
  end
  
end
