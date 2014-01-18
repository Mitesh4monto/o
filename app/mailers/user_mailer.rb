class UserMailer < ActionMailer::Base
  default from: "oscar@haham.net"
  
  def welcome(user)
    @user = user
    # attachments["logo"] = File.read("#{Rails.root}/public/images/lobehold.png")
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end
