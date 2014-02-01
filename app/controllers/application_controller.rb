class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_updates

  def get_updates
    @udpates = ActionLog.latest(current_user) if current_user
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
  
end
