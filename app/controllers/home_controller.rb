class HomeController < ApplicationController
  def index    
    if (current_user)
      redirect_to myp_path, :notice => notice
    else 
      redirect_to courses_path, :notice => notice
      # @courses = Course.published.paginate(:page => params[:page], :per_page => 10).order("created_at desc")
    end
  end
  
end
