class CoursesController < ApplicationController
  before_filter :require_owner, :only =>[:edit, :update, :destroy, :plan_edit, :overview_edit, :description_edit, :publish_course, :update_description]
  before_filter :authenticate_user!, :except =>[:index, :hals, :show, :overview, :plan, :description]


  # GET /courses
  # GET /courses.json
  def index
    if (params[:query])
      @courses = Course.full_course_search(params[:query]).published.page(params[:page]).per_page(10)
    else 
      @courses = Course.published.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    end
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
  
  def view
    @course = Course.find(params[:id])    
    if @course.user != current_user and !@course.published?
      return redirect_to :root, notice: 'Nothing here'       
    end
    @hals = @course.hals.not_private
    @followers = @course.get_course_followers
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    part = params[:part] || "overview"
    if @course.user != current_user and !@course.published?
      return redirect_to :root, notice: 'Nothing here'       
    end
    @hals = @course.hals.not_private
    @followers = @course.get_course_followers
    # puts @followers.inspect
    
    render "overview"
  end
  
  def edit    
    render "plan_edit"
  end
  
  def edit_course
    @course = Course.find(params[:id])
  end
  
  # owner edits plan
  def plan_edit
    @course = Course.find(params[:id])    
    @activity = Activity.find_by_id(params[:activity_id])
    @activity = @course.strategy.current_activities.first if !@activity
  end

  # owner edits plan
  def description_edit
    @course = Course.find(params[:id])    
  end


  # owner edits overview
  def overview_edit
    @course = Course.find(params[:id])
  end
  
  def blogs
    @course = Course.find(params[:id])    
  end
  
  def plan
    @course = Course.find(params[:id])    
    @by = params[:by]
    @activity = Activity.find_by_id(params[:activity_id])
    @activity = @course.strategy.current_activities.first if !@activity
  end

  def description
    @course = Course.find(params[:id])    
  end

  def people
    @course = Course.find(params[:id])    
  end


  def overview
    @course = Course.find(params[:id])
  end

  
  # owner publishes their course
  def publish_course
    @course = Course.find(params[:id])
    if !course_ok?(@course)
      return redirect_to :back
    end      
    @course.published = true
    respond_to do |format|
      if @course.save
        format.html { redirect_to :back, notice: "Your course is now published. View it <a href='/courses/#{@course.id}'>here</a>".html_safe }
      else
        format.html { redirect_to :back, notice: 'Something went kaboom' }
      end
    end
    
  end
  
  def course_ok?(course)
    if course.strategy.current_activities.size > 0
      true
    else
      flash[:errors] = "hey add some activities to your plan"
      false
    end
  end
  
  def join
    @course = Course.find(params[:id])
    @course.add_user_to_course(current_user)
    if @course.has_customizations?
      notice = 'Course was successfully joined.  We recommend you turn on customizations to tweak it for you'
    else
      notice = 'Course was successfully joined'
    end
    
    redirect_to root_path, notice: notice
    
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


  # post course info on user's wall on fb
  def share_course_on_fb    
    @course = Course.find(params[:id])
    
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    url = "http://www.melearni.ng/courses/33"  #url_for(@course)   TODO change for prod
    puts "url: #{url}"
    puts @course.post_print
    graph.put_wall_post(@course.post_print, {:name => "My New course", :link => url})
    redirect_to @course, notice: 'posted.'      
  end



  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_plan_edit_path(@course), notice: 'Course was successfully created.' }
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
          format.html { redirect_to course_overview_path(@course), notice: 'Course was successfully updated.' }
        format.json { render json: "copacetic" }
      else
        format.html { render action: "edit", notice: 'Course was databasely challenged.'  }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_description
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update_attributes(params[:course])
          format.html { redirect_to course_description_path(@course), notice: 'Course Description was successfully updated.' }
      else
        format.html { render action: "description" }
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
      format.html { redirect_to my_created_courses_path, notice: 'Course was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
  
  private 
  # ensure the course is owned by logged in user
  def require_owner
    @course = Course.find_by_id(params[:id])
    if (!@course || @course.user != current_user)
      redirect_to :root, notice: 'Not yours.  Pas touche.'      
    end
  end
  
  
end
