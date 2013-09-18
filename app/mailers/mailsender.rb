#
# Código tomado de
#     http://guides.rubyonrails.org/action_mailer_basics.html
#

class Mailsender < ActionMailer::Base
  
  def loadConfiguration
    ActionMailer::Base.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => "gmail.com",
      :user_name            => "rr.ricci",
      :from                 => "rr.ricci@gmail.com",
      :password             => "contrasenia",
      :authentication       => "plain",
      :enable_starttls_auto => true
    }
  end
  
  def resetPassword(user, password)
    loadConfiguration()
    
    @user = user
    @password = password
    @url  = "http://pis-prototipo-2013.herokuapp.com/"
    
    mail(to: "rr.ricci@gmail.com", subject: "WIRA - Nueva contraseña")
  end
  
  
end
