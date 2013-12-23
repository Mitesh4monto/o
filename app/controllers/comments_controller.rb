class CommentsController < ApplicationController
  
  def create
    @hal = Hal.find(params[:hal_id])
    @comment = @hal.comments.create(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    redirect_to params[:red]
  end  
  
end
