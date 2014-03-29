module StrategiesHelper

  def shorten(text, length)
    strip_tags(text.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= length);ob << (" " + x)}.strip)
  end
  
  def myp_status
    status = ''
  	if current_user.strategy.current_activities.empty? and current_user.sign_in_count == 1
  		status += "If you want to #{link_to 'create a course, click here.', create_course_path}<BR><BR>"
  	end
    if current_user.strategy.current_activities.empty?
  		status += "Your plan is empty.  Would you like to:<BR>
  			#{link_to 'Add a course from here....', courses_path}<BR>
  			#{link_to 'Add and activity', add_activity_path}<BR>
  			Or see what other #{link_to 'users', users_path} are doing and add an activity from them <BR>"
    end
    if !current_user.strategy.current_activities.empty? and current_user.hals.empty?
      status += "You can add a blog entry about an activity #{link_to 'here', new_hal_path}<BR>"
    end
    status
  end
  
end
