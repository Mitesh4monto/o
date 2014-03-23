class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    create_course_path
  end
  
  def after_inactive_sign_up_path_for(resource)
     if session[:course_join] != nil      
       course = Course.find(session[:course_join])
       course.add_user_to_course(resource)       
       session[:course_join] = nil
       course_overview_path(course)
     else
       # course = Course.find(114)
       # course.add_user_to_course(resource)       
       root_path
     end
  end
  
end