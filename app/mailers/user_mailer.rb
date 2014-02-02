class UserMailer < ActionMailer::Base
  default from: "oscar@haham.net"
  
  def welcome(user)
    @user = user
    # attachments["logo"] = File.read("#{Rails.root}/public/images/lobehold.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end

  def contact(message, user = nil)
    if user
      mail(:from => user.email, :to => "oscar@haham.net", :subject => "from user id #{user.id}, named #{user.name}", :body => message.content)
    else
      mail(:to => "oscar@haham.net", :subject => "from: #{message.name}, #{message.email}", :body => message.content)
    end
  end

end
