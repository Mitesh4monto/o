module CoursesHelper
  
  def short_description(course)
    return "" if !course.description
    desc = ActionController::Base.helpers.strip_tags(course.description)
    desc.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 60);ob << (" " + x)}.strip
  end
  
  def course_status(course)
    status = ''
    status += "There are currently no activities in your course.  Add some by going to the #{link_to 'activity tab', course_plan_edit_path(course)}<BR>" if (course.strategy.current_activities.size == 0)
    status += "You would benefit from adding a  #{link_to 'detailed description.', course_description_edit_path(course)}<BR>" if (!course.description)    
    status += "Your course is unpublised.<BR>" if (!course.published)
  end
  
end
