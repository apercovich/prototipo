#
# Código tomado de
#     http://guides.rubyonrails.org/action_mailer_basics.html
#

class Mailsender < ActionMailer::Base
  default from: "fing.pis.2013@gmail.com"
  
  URL  = "http://pis-prototipo-2013.herokuapp.com/"
  
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => "587",
    :authentication       => "plain",
    :user_name            => "fing.pis.2013",
    :password             => "pis123456",
    :domain               => "gmail.com",
    :enable_starttls_auto => true
  }
  
  
  def resetPassword(user)
    @user = user
    @url  = URL
    mail(to: @user.email, subject: "WIRA - Nueva contraseña")
  end
  
  def newUser(user)
    @user = user
    @url  = URL
    mail(to: @user.email, subject: "WIRA - Nuevo usuario")
  end
  
  def changePassword(user)
    @user = user
    @url  = URL
    mail(to: @user.email, subject: "WIRA - Contraseña modificada")
  end
  
  
end
