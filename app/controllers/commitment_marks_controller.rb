class CommitmentMarksController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /commitment_marks
  # GET /commitment_marks.json
  def index
    @commitment_marks = CommitmentMark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commitment_marks }
    end
  end

  def mycms
    @date = params[:month] ? Date.parse(params[:month]) : Date.today        
  end

  def add_commitment_mark_to_activity
    # TODO check that one doesn't already exist for today
    @activity = Activity.find(params[:activity_id])
    if (@activity.user_id != current_user.id) 
      redirect_to :myp, :notice => "not yours"
      return
    end
    @commitment_mark = CommitmentMark.new
    @commitment_mark.cmable = @activity
    @commitment_mark.done_date = Date.current
    @commitment_mark.user_id = current_user.id
    @commitment_mark.save  #TODO check this that
    flash[:activity_id] = params[:activity_id]
    flash[:partial] = "commitment_logged"
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

end
