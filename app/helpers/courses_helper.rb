module CoursesHelper
  
  def short_description(course)
    return "" if !course.description
    desc = ActionController::Base.helpers.strip_tags(course.description)
    desc.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 60);ob << (" " + x)}.strip
  end
  
end
