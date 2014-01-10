class CommitmentMarksController < ApplicationController
  # GET /commitment_marks
  # GET /commitment_marks.json
  def index
    @commitment_marks = CommitmentMark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commitment_marks }
    end
  end

  def add_commitment_mark_to_activity
    # TODO check that one doesn't already exist for today
    @commitment_mark = CommitmentMark.new
    @commitment_mark.cmable = Activity.find(params[:activity_id])
    @commitment_mark.done_date = Date.current
    @commitment_mark.user_id = current_user.id
    @commitment_mark.save  #TODO check this that
    flash[:activity_id] = params[:activity_id]
    flash[:partial] = "commitment_logged"
    redirect_to :back
  end

end
