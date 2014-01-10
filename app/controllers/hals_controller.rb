class HalsController < ApplicationController
  before_filter :authenticate_user!, :except =>[:show, :help_wanted]

  def view_mine
    @hals = current_user.hals
  end

  def new_hal
    @hal = Hal.new
  end
  
  def help_wanted
    @hals = Hal.help_wanted
  end
  
  def following
    @hals = current_user.find_following_hals    
  end
  
  
  def hal_about_activity
    @hal = Hal.new
    @activity = Activity.find(params[:id])
    @from_course = !@activity.course_id.blank?
    @halable_id = params[:id]
    @halable_type = "Activity"
  end
  
  def create
    @hal = Hal.new(params[:hal])
    if (@hal.halable_id == 0) 
      @se = current_user.strategy
    else
      @se = @hal.halable
      # @se = Activity.find(@hal.halable_id)
    end
  	
    @hal.hal_about(@se)

    redirect = params[:from] || myp_path
    
    respond_to do |format|
      if @hal.save
        format.html { redirect_to redirect, notice: 'HAL was successfully created' }   #TODO CLEANUP
        # format.html { redirect_to @hal, notice: 'Hal was successfully created.' }
        format.json { render json: @hal, status: :created, location: @hal }
      else
        format.html { render action: "new" }
        format.json { render json: @hal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @hal = Hal.find(params[:id])    
  end
  
  def update
    @hal = Hal.find(params[:id])

    respond_to do |format|
      if @hal.update_attributes(params[:course])
        format.html { redirect_to root_path, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hal.errors, status: :unprocessable_entity }
      end
    end
  end
  
    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @hal = Hal.find(params[:id])
      @hal.destroy

      respond_to do |format|
        format.html { redirect_to "/hals/view_mine" }
        format.json { head :no_content }
      end
    end
  end
