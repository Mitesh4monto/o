class CoursesController < ApplicationController
  before_filter :require_owner, :only =>[:my_created, :edit_course, :destroy, :publish_course, :update_description, :overview_update]
  before_filter :authenticate_user!, :except =>[:index, :hals, :show, :join]


  # GET /courses
  # GET /courses.json
  def index
    if (params[:query])
      @courses = Course.full_course_search(params[:query]).listed.page(params[:page]).per_page(10)
    else 
      @courses = Course.listed.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
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

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    @tab = params[:tab] || "overview"
    if @course.user != current_user and !@course.published?
      return redirect_to :root, notice: 'Nothing here'       
    end
    @hals = @course.hals.not_private
    @followers = @course.get_course_followers
    # puts @followers.inspect
  end
  
  def edit_course
    @course = Course.find(params[:id])
    @tab = params[:tab] || 0
    actid = params[:format] || nil
    @activity = Activity.find_by_id(actid) #|| @course.activities.first
    puts "tab: #{@tab}"
  end
  
  # ajax call for description update
  def update_description
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update_attributes(params[:course])
        flash[:notice] = "Course updated Successfully"
      else
        flash[:error] = "An error occured!"
      end
      format.html
      format.js
    end
  end
  
  
  # ajax call for overview update
  def overview_update
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update_attributes(params[:course])
        flash[:notice] = "Course updated Successfully"
      else
        flash[:error] = "The overview could not be saved"
      end
      # format.html 
      format.js
    end
  end
  
  
  def plan
    @course = Course.find(params[:id])    
    @by = params[:by]
    @activity = Activity.find_by_id(params[:activity_id])
    @activity = @course.strategy.current_activities.first if !@activity
  end

  # owner publishes their course
  def publish_course
    @course = Course.find(params[:id])
    if !course_ok?(@course)
      return redirect_to edit_course_path(@course)
    end      
    @course.publish
    respond_to do |format|
      if @course.save
        flash[:notice] =  "Your course is now published. View it <a href='/courses/#{@course.id}'>here</a>".html_safe 
        format.html { redirect_to @course}
      else
        flash[:error] =  'Something went kaboom'
        format.html { redirect_to :back }
      end
    end
    
  end
  
  # used for guiding ppl who want to publish
  def course_ok?(course)
    if course.publishable?
      true
    else
      flash[:error] = "The course doesn't have any activities.  Add some before publishing."
      false
    end
  end
  
  # user joins course
  def join
    @course = Course.find(params[:id])
    if (!current_user)
      flash[:notice] = "Please login or register to join course #{@course.name}"
      session[:course_join] = @course.id
      redirect_to signin_path
    else    
      @course.add_user_to_course(current_user)
      if @course.has_customizations?
        notice = 'Course was successfully joined.  We recommend you turn on customizations to tweak it for you'
      else
        notice = 'Course was successfully joined'
      end
    
      redirect_to root_path, notice: notice
    end
    
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html
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
    @tab = 1

    respond_to do |format|
      if @course.save
        format.html {   flash[:notice] = 'Course was successfully created.'
                        render :edit_course}
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
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
