class ActivityInSequencesController < ApplicationController
  before_filter :authenticate_user!, :except =>[:show]
  before_filter :require_owner, :only =>[:edit, :update, :destroy]


  def add_to_sequence
    @seq_activity = Activity.find_by_id(params[:id])
    @activity = ActivityInSequence.new
    if (!@seq_activity || @seq_activity.user != current_user)
      redirect_to @activity, notice: 'Not yours.  Pas touche.  || dunt exist'      
    end
  end



  # POST /activities
  # POST /activities.json
  def create
    @seq_activity_id = params[:seq_activity]
    @activity = ActivityInSequence.new(params[:activity_in_sequence])
    # if adding to a course, point act to course
    existing_act = Activity.find_by_id(params[:seq_activity])
    @activity.course_id = existing_act.course_id
    ActivitySequence.add_activity_to_sequence_with(@activity, existing_act)
    @activity.user_id = current_user.id
    
    respond_to do |format|
      if @activity.save
          format.html { redirect_to activity_sequence_path(@activity.activity_sequence_id), notice: 'Activity was successfully created.' }          
      else
        format.html { render action: "add_to_sequence" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /activities/1
# DELETE /activities/1.json
def destroy
  @activity = ActivityInSequence.find(params[:id])
  course = @activity.course
  @activity.activity_sequence.destroy_activity(@activity)

  respond_to do |format|
    #  assumes can only remove activity form activity sequence in course
    format.html { redirect_to course, notice: "Activity and sequence were successfully deleted" }
    format.json { head :no_content }
  end
end

end