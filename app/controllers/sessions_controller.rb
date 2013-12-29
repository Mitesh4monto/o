class SessionsController < ApplicationController #Devise::SessionsController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    sign_in_and_redirect user, :event => :authentication #this will throw if @user is not activated
    # redirect_to root_url
  end
  
end