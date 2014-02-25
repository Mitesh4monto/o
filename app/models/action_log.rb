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
  
  # log other actions of an object
  def self.log_other(user_id, action, obj, link = nil)
    al = ActionLog.new(:user_id => user_id, :action => action, :link => link)
    al.loggable = obj
    al.save
  end
  
  
  # get the latest action logs for a particular user
  def self.latest(user, qty = 10)
    #  get list of course owners user is following
    following_courses = user.get_following_courses
    # puts following_courses.to_yaml
    course_owners_id_list = []
    following_courses.each {|course| course_owners_id_list.push(course.user_id)
      # puts "course: " + course.to_yaml
      # puts "-#{course.user_id}-" 
      }
    # get latest for following updates plus course owners
    users_id_list = user.following.pluck(:id)
    # puts "-#{course_owners_id_list}-"    
    # puts "-#{users_id_list}-"
    users_id_list.concat(course_owners_id_list)
    # puts users_id_list.join(',')
    # puts "size: #{users_id_list.size}"
    if (users_id_list.size > 0 )
      # puts "user_id in (#{users_id_list.join(',')})"
      ActionLog.find_by_sql("select * from action_logs where user_id in (#{users_id_list.join(',')}) and id in(select max(id) from action_logs group by action, loggable_type, user_id, loggable_id) order by created_at desc limit #{qty}")
      # ActionLog.where(user_id: users_id_list).order('created_at DESC').limit(qty)
    else
       []
    end
  end
  
  
end
