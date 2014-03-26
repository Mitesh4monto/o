class ActivityInSequencesController < ActivitiesController
  before_filter :authenticate_user!, :except =>[:show]
  before_filter :require_owner, :only =>[:edit, :update, :destroy]


  def add_to_sequence
    @seq_activity = Activity.find_by_id(params[:id])
    @activity = ActivityInSequence.new
    if (!@seq_activity || @seq_activity.user != current_user)
      redirect_to @activity, notice: 'Not yours.  Pas touche.  || dunt exist'      
    end
  end

  # create new activity_in_sequence and place it in activity sequence.  create goal if new one specified
  def create
    @activity = ActivityInSequence.new(params[:activity_in_sequence])
    # if adding to a course, point act to course
    existing_act = Activity.find_by_id(params[:seq_activity])
    @activity.course_id = existing_act.course_id
    ActivitySequence.add_activity_to_sequence_with(@activity, existing_act)
    @activity.user_id = current_user.id
    if !@activity.new_goal_text.empty?
      goal = existing_act.course.strategy.create_or_use_goal(@activity.new_goal_text)
      @activity.goal_id = goal.id
    end
    
    puts "course: #{@activity.course.inspect}"

    #  log action
    ActionLog.log_other(current_user.id, "update", @activity.course)  if @activity.course.published?
    
    
    respond_to do |format|
      if @activity.save
          format.html { redirect_to activity_sequence_path(@activity.activity_sequence_id), notice: 'Activity was successfully created.' }          
      else
        format.html { render action: "add_to_sequence" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete_as
    @activity = ActivityInSequence.find(params[:id])  
    strategy = @activity.activity_sequence.strategy
    # puts "coooooooours: #{course.id}"
    @activity.activity_sequence.destroy

    respond_to do |format|
      if (strategy.type == "UserStrategy")
        #  assumes can only remove activity form activity sequence in course
        format.html { redirect_to myp_path, notice: "Activity and sequence were successfully deleted" }
        format.json { head :no_content }
      else
        #  assumes can only remove activity form activity sequence in course
        format.html { redirect_to course_plan_edit_path(course), notice: "Activity and sequence were successfully deleted" }
        format.json { head :no_content }
      end
    end
  end

# DELETE /activities/1
# DELETE /activities/1.json
def destroy
  @activity = ActivityInSequence.find(params[:id])  
  course = @activity.activity_sequence.strategy.course
  # puts "coooooooours: #{course.id}"
  @activity.activity_sequence.destroy_activity(@activity)

  respond_to do |format|
      #  assumes can only remove activity form activity sequence in course
      format.html { redirect_to course_plan_edit_path(course), notice: "Activity and sequence were successfully deleted" }
      format.json { head :no_content }
  end
end




end