class HomeController < ApplicationController
  def index    
    if (current_user)
      redirect_to myp_path, :notice => notice
    end
  end
end
