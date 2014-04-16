class HalsController < ApplicationController
  before_filter :require_owner, :only =>[:edit, :update, :destroy]
  before_filter :authenticate_user!, :except =>[:show, :help_wanted]

  def view
    @mine = current_user.hals.first(10)
    @following = current_user.find_following_hals.public.first(10)
    @courses_hals = current_user.find_course_hals.public.first(10)
    @all = Hal.public.first(30)
    @help = Hal.help_wanted.public.first(10)
    @insighted = current_user.hals.where("insights <> ''").first(10)
    @tab = params[:tab] || 0
  end

  def show
    @hal = Hal.find(params[:id])
    if (current_user != @hal.user and @hal.private?)
      return redirect_to :root, notice: "This is not the blog you're looking for"
    end
  end
  
  def edit
    @hal = Hal.find(params[:id])    
  end

  def new_hal
    @hal = Hal.new
    @activity = Activity.find_by_id(params[:id])
  end
  
  def create
    redirect = params[:from] || myp_path
    if params[:cancel] 
       redirect_to redirect
       return
    end
          
    @hal = Hal.new(params[:hal])
    @hal.user_id = current_user.id
    if (@hal.halable_id == 0) 
      @activity = nil
    else
      @hal.halable_type = "Activity"
      @activity = @hal.halable
    	@hal.hal_about(@activity)
    	redirect = params[:from] || myp_path(@hal.halable)
    end
    
    respond_to do |format|
      if @hal.save      
        # if we're also sharing on fb:  post to wall
        if params['fbshare.x'] 
          graph = Koala::Facebook::API.new(current_user.oauth_token)
          a = graph.put_wall_post(@hal.post_print(url_for(:controller => 'hals', :action => 'show', :id => @hal.id)))
        end
        
        format.html { redirect_to redirect, notice: 'Entry was successfully created' }   #TODO CLEANUP
        # format.html { redirect_to @hal, notice: 'Hal was successfully created.' }
        format.json { render json: @hal, status: :created, location: @hal }
      else        
        format.html { render :new_hal, notice: "Could not save" }
        format.json { render json: @hal.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @hal = Hal.find(params[:id])

    respond_to do |format|
      if @hal.update_attributes(params[:hal])
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
