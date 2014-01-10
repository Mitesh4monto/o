class CoursesController < ApplicationController
  before_filter :authenticate_user!, :except =>[:index, :hals, :show]


  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.published
    @followers = Course.get_number_people_following_published_courses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # all hals for a course
  def hals
    @course = Course.find(params[:id])
    # don't show any private hals
    @hals = @course.hals.not_private
  end

  def my_created
    @courses = current_user.courses
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    @hals = @course.hals.not_private
    @followers = @course.get_course_followers
    puts @followers.inspect

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end
  
  def join
    @course = Course.find(params[:id])
    @course.add_user_to_course(current_user)
    
    redirect_to root_path, notice: 'Course was successfully joined.'
    
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit    
    @course = Course.find(params[:id])
    if (@course.user != current_user)
      redirect_to @course, notice: 'Not yours.  Pas touche.'      
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to my_created_courses_path }
      format.json { head :no_content }
    end
  end
end
