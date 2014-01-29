class ActivitySequencesController < ApplicationController
  def show    
    @activity_sequence = ActivitySequence.find(params[:id])
  end
  
  # selected acitivyt in sequence is active
  def make_current
    @activity = Activity.find(params[:id])
    @activity.activity_sequence.set_current(@activity)
    redirect_to @activity.activity_sequence
  end

  # sort list of actiities in strategy   => TODO optimize
  def sort
    params[:activity_in_sequence].each_with_index do |id, index|
      activity = Activity.find_by_id(id)
      Activity.update_all(['act_seq_order=?', index+1], ['id=?', id]) unless activity.user_id != current_user.id
    end
    render :nothing => true
  end
  
  # next in sequence is active
  def set_next
    @activity_sequence = ActivitySequence.find(params[:id])        
    @activity_sequence.set_next
    redirect_to :myp
  end
  
  # previous in sequence is active
  def set_previous
    @activity_sequence = ActivitySequence.find(params[:id])
    @activity_sequence.set_previous
    redirect_to :myp    
  end
end
