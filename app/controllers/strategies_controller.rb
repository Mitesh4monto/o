class StrategiesController < ApplicationController
  before_filter :authenticate_user!

  def mine
    @related_hals = Hal.get_hals_related_to_strategy(current_user.strategy)
    @udpates = ActionLog.latest(current_user)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today    
    @activity = Activity.find_by_id params[:id]
  end

  def copy_activity
    @activity = Activity.find(params[:id])
    @activity.copy_to_user(current_user)
    redirect_to root_path, notice: 'activity was successfully added.'
  end
  

  
  def mine_details
    # UserMailer.welcome(current_user).deliver
    # date for commitment marks
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @udpates = ActionLog.latest(current_user)
    
    @activity = Activity.find_by_id params[:id]
    if !@activity then
      return redirect_to :myp      
    end
    @commitment_marks = @activity.commitment_marks
    if (@activity.from_id) then
      @activity_from = Activity.find_by_id @activity.from_id
      if (@activity_from) then 
        if @activity_from.course_id then 
          @course = @activity_from.course
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
