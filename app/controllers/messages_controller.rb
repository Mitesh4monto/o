class MessagesController < ApplicationController
  def new
    @message = Message.new
  end
  
  def news
    email = params[:email]
    # debugger
    @message = Message.new(:name => 'ss', :email => email, :content => "newsletter thing - #{email}")
    UserMailer.contact(@message).deliver!
    
    respond_to do |format|
      # format.html { redirect_to root_path }
      format.js
    end
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