#
# Este controlador, junto con el ayudante sessions_helper, incluyen todo lo necesario para manejar las sesiones.
# En particular, para almacenar el estado de un usuario, Rails provee una funcion llamada "session"
# que permite guardar valores de la forma "session[:remember_token] = user.id".
# En otros lugares del sistema simplemente se haria "User.find(session[:remember_token])"
# para recuperar al usuario logueado.
#
# Pero en nuestro caso, necesitamos que la sesion siga abierta aunque se cierre el navegador
# (llamado 'persistent sessions'), por eso se implementa un manejo personalizado de cookies.
#
# Por mas referencias: http://ruby.railstutorial.org/chapters/sign-in-sign-out
#
#
# Proceso de registro e inicio de sesion:
#   1) Cuando el usuario se registra, se crea y guarda en la BD el token asociado a la sesion.
#      Esto permite iniciar automaticamente la misma.
#   2) Al iniciar sesion, se crea un nuevo token y se guarda en una cookie y en la BD.
#   3) La cookie se borra solo al cerrar explicitamente la sesion.
#   4) El token se guarda sin encriptar en la cookie, pero encriptado en la BD. Esto evita que, si alguien
#      consigue acceso a la BD, no podra crear manualmente una cookie.
#   5) Cada vez que el usuario inicia sesion, se crea un nuevo token. Con esto, si alguien consiguio la informacion
#      de la cookie, perdera el acceso la proxima vez que el usuario real inicie normalmente la sesion.
#   6) Ademas, para evitar que alguien pueda "ver" los datos de la cookie viajando por la red, por ejemplo en
#      redes wi-fi publicas, se realiza una comunicacion mediante SSL.
#
#


class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by(name: params[:session][:name].downcase)
    
    if user && user.authenticate(params[:session][:password])
      # Inicio la sesion del usuario y lo redirijo a la pagina principal
      sign_in(user)
      flash[:success] = "Sesión iniciada correctamente!!!"
      redirect_to user #Esto va a show.html, falta la pagina principal
      
    else
      # Creo un mensaje de error y re-renderizo el formulario de inicio de sesion.
      flash.now[:error] = 'El nombre de usuario o la contraseña es incorrecto'
      render 'new'
    end
  end
  
  def destroy
    sign_out()
    flash[:success] = "Sesión cerrada"
    redirect_to root_url
  end
  
end
