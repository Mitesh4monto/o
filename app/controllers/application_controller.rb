class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_updates

  def get_updates
    @udpates = ActionLog.latest(current_user) if current_user
  end
  
  def post_sign_in(user)
    post_register(user) if (user.sign_in_count == 1)
  end
  
  def post_register(user)
    puts '****************************234********************************'
    if session[:course_join] != nil      
      course = Course.find(session[:course_join])
      course.add_user_to_course(user)       
      session[:course_join] = nil
    else
      puts '************************************************************'
      course = Course.find(AppSetting.get('intro_course'))
      course.add_user_to_course(user)       
    end    
  end
    
  # used in before filter to make sure object can be viewed/modified by current user
  def require_owner
      object = controller_name.classify.constantize.find_by_id(params[:id])
      # puts object.inspect
      unless current_user && object.user_id == current_user.id
        respond_to do |format|
          format.html { render :text => "Not Allowed", :status => :forbidden }
        end
      end
  end
  
  protected
  def after_update_path_for(resource)
      my_profile_path
  end
      
  def after_sign_out_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]eeee'
    '/courses'
  end
      
  def after_sign_in_path_for(resource)
    post_sign_in(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    puts '[****************************************][[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]'
      post_register(resource)    
      courses_path
  end
  
  def after_inactive_sign_up_path_for(resource)
    puts '*asdf***************************************[[[[[[[[[[[[]]]]]]]]]]]]'
    post_register(resource)    
    courses_path
  end
  
  
end
