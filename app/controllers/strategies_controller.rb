class StrategiesController < ApplicationController
  before_filter :authenticate_user!

  def mine
    @related_hals = Hal.get_hals_related_to_strategy(current_user.strategy)
  end


  def copy_activity
    @activity = Activity.find(params[:id])
    current_user.strategy.copy_activity_to_strategy(@activity)
    redirect_to root_path, notice: 'activity was successfully added.'
  end
  

  
  def mine_details
    @activity = Activity.find params[:id]
    if (@activity.from_id) then
      @activity_from = Activity.find_by_id @activity.from_id
      if (@activity_from) then 
        if @activity_from.get_course_id then 
          @course = Course.find @activity_from.get_course_id
        else 
          @from_user_activity = @activity_from.user
        end
      else
        @course = nil
      end
    end
    @related_hals_activity = Hal.get_related_hals(@activity)
  end
  
end
