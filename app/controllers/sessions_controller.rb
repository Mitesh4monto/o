class SessionsController < ApplicationController #Devise::SessionsController
  def create
    if (params[:error])
      # TODO LOGGG
      redirect_to root_path, notice: 'Refused...'
    end
    user = User.from_omniauth(env["omniauth.auth"])
    sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    # redirect_to root_url
  end
  
end