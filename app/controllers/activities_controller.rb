class ActivitiesController < ApplicationController
  before_filter :authenticate_user!, :except =>[:show]
  before_filter :require_owner, :only =>[:edit, :update, :destroy]


  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])
    @hals = @activity.hals
    @related_hals = Hal.get_related_hals(@activity)
    @date = params[:month] ? Date.parse(params[:month]) : Date.today    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # sort list of actiities in strategy   => TODO optimize
  def sort
    params[:activity].each_with_index do |id, index|
      activity = Activity.find_by_id(id)
      Activity.update_all(['position=?', index+1], ['id=?', id]) unless activity.user_id != current_user.id
    end
    render :nothing => true
  end
  
  def add_to_sequence
    @seq_activity = Activity.find_by_id(params[:id])
    @activity = Activity.new
    if (!@seq_activity || @seq_activity.user != current_user)
      redirect_to @activity, notice: 'Not yours.  Pas touche.  || dunt exist'      
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end
  
  # Add a new activity to a course user has created
  def add_activity_to_course
    @activity = Activity.new
    @course = Course.find_by_id(params[:id])
    if (!@course || @course.user != current_user)
      redirect_to @course, notice: 'Not yours.  Pas touche.  || dunt exist'      
    end
  end
  
  # Add a new activity to a course user has created
  def edit_activity_in_course
    @activity = Activity.find(params[:id])
    @course = @activity.strategy.course
    if (!@course || @course.user != current_user)
      redirect_to @course, notice: 'Not yours.  Pas touche.  || dunt exist'      
    end    
  end
  

  def create_activity_in_course
    @activity = Activity.new(params[:activity])
    puts "duration: #{@activity.duration_unit}"
    puts "duration num: #{@activity.duration_number}"
    @course = Course.find_by_id(params[:course_id])
    if !@activity.new_goal_text.empty?
      goal = @course.strategy.create_or_use_goal(@activity.new_goal_text)
      @activity.goal_id = goal.id
    end
    if (@course.user_id != current_user.id)   # TODO do better?
      redirect_to :myp, :notice => "not yours"
      return
    end
    @course.add_activity(@activity)
    @activity.user_id = current_user.id
    
    ActionLog.log_other(current_user.id, "update", @course)  if @course.published?
    
    respond_to do |format|
      if @activity.save
          # log action
          ActionLog.log_update(@course)         
          format.html { redirect_to course_plan_edit_path(@course.id), notice: 'Activity was successfully created.' }
      else
          format.html { render action: "add_activity_to_course" }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end    
  end


  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
    redirect_to @activity, notice: 'No way, not yours.'  if (@activity.user_id != current_user.id)
  end
  

  # POST /activities
  # POST /activities.json
  # create activity for a user's plan
  def create
    # debugger
    @activity = Activity.new(params[:activity])
    # jquery dp hack
    until_date = params[:activity][:timing_until]
    @activity.timing_until = Date.strptime(until_date, "%m/%d/%Y") if !until_date.blank?
    course_id = params[:course_id]    
    @activity.strategy = current_user.strategy
    @activity.user_id = current_user.id
    # create new goal if new_goal_text filled in
    if !@activity.new_goal_text.empty?
      goal = current_user.strategy.create_or_use_goal(@activity.new_goal_text)
      @activity.goal_id = goal.id
    end
    
    # log creation
    ActionLog.log_create(@activity)             
    
    respond_to do |format|
      if @activity.save
        ActionLog.log_create(@activity)                 
        if params[:seq_activity]
          format.html { redirect_to activity_sequence_path(@activity.activity_sequence_id), notice: 'Activity was successfully created.' }          
        else
          format.html { redirect_to myp_path, notice: 'Activity was successfully created.' }
        end
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    # add new goal if entered
    new_goal_text = params[:activity][:new_goal_text]
    if !new_goal_text.empty?
      goal = @activity.strategy.create_or_use_goal(new_goal_text)
      @activity.goal_id = goal.id
    end    
    
    # log update activity
    if (@activity.strategy and @activity.strategy.class.name == "CourseStrategy")
      @course = @activity.strategy.course
      ActionLog.log_other(current_user.id, "update", @course)  if @course.published?
    else
      ActionLog.log_update(@activity)             
    end    
    

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        if @activity.myp_activity?
          format.html { redirect_to mypd_path(@activity), notice: 'Activity was successfully updated.' }
          format.json { head :no_content }
        elsif @activity.course_activity?
          format.html { redirect_to course_plan_edit_path(@activity.strategy.course), notice: 'Activity was successfully updated.' }
          format.json { head :no_content }          
        else 
          format.html { redirect_to root_path, notice: 'Activity was successfully updated.' }
          format.json { head :no_content }          
        end
      else
        flash[:error] = "Some errors occured - Activity Could not be saved"
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])

    # log deletion
    if (@activity.strategy and @activity.strategy.class.name == "CourseStrategy")
      ActionLog.log_other(current_user.id, "update", @course)  if @activity.strategy.course.published?
    else
      ActionLog.log_destroy(@activity)             
    end    

    @activity.destroy
    
    respond_to do |format|
      format.html { redirect_to :back, notice: "Activity was successfully deleted" }
      format.json { head :no_content }
    end
  end
  
  
end
