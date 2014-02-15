class UserMailer < ActionMailer::Base
  default from: "info@melearni.ng"
  
  def welcome(user)
    @user = user
    # attachments["logo"] = File.read("#{Rails.root}/public/images/lobehold.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered", :body => "fdsfs")
  end

  def contact(message, user = nil)
    if user
      mail(:to => user.email, :subject => "from user id #{user.id}, named #{user.name}", :body => message.content)
    else
      mail(:to => "lemuel@melearni.ng", :subject => "from: #{message.name}, #{message.email}", :body => message.content)
    end
  end

end
