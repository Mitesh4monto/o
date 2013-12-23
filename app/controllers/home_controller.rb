class HomeController < ApplicationController
  def index    
    if (current_user)
      redirect_to myp_path
    end
  end
end
