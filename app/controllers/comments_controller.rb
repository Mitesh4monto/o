class CommentsController < ApplicationController
  before_filter :require_owner, :only =>[:destroy]
  before_filter :authenticate_user!
  
  def create
    @hal = Hal.find(params[:hal_id])
    @comment = @hal.comments.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    redirect_to params[:red]
  end  
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
