class ActionLog < ActiveRecord::Base
  belongs_to :loggable, :polymorphic => true
  belongs_to :user

  # log the creation of a new object
  def self.log_create(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "create", :link => link)
    al.loggable = obj
    al.save
  end
  
  # log the update of an object
  def self.log_update(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "update", :link => link)
    al.loggable = obj
    al.save
  end
  
  # log the deletion of an object
  def self.log_destroy(obj, link = nil)
    al = ActionLog.new(:user_id => obj.user_id, :action => "destroy", :link => link)
    al.loggable = obj
    al.save
  end
  
  # get the latest action logs for a particular user
  def self.latest(user, qty = 10)
    #  get list of course owners user is following
    following_courses = user.get_following_courses
    course_owners_id_list = []
    following_courses.each {|course| course_owners_id_list << course.user_id }
    # get latest for following updates plus course owners
    users_id_list = user.following.pluck(:id)
    users_id_list.concat(course_owners_id_list)
    if (users_id_list.size > 0 )
      ActionLog.where("user_id in (#{users_id_list.join(',')})").order('created_at DESC').limit(qty)
    else
       []
    end
  end
  
end
