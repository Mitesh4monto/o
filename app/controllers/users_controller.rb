class UsersController < ApplicationController
  before_filter :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  def myprofile        
  end
  
  def edit_profile
    @user = current_user    
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_path, notice: 'Updated!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to params[:red], notice: "Now following #{@user.name}."
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to params[:red], notice: "No longer following #{@user.name}."
  end
  
end
