class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.contact(@message, current_user).deliver!
      flash[:notice] = "Message sent! Thank you for contacting us."
      redirect_to controller: "Messages", action: 'sent'
    else
      render "new"
    end
  end
  
  def sent    
  end
end