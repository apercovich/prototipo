module SessionsHelper
  
  # Esta operacion crea y guarda el token asociado a la sesion
  def sign_in(user)
    remember_token = User.new_remember_token
    
    # Cada cookie puede contener un valor y una fecha de expiracion.
    # Observar como se puede utilizar el ayudante para fechas incluido en Rails
    # Por mas informacion: http://ruby.railstutorial.org/chapters/sign-in-sign-out#sidebar-time_helpers
    cookies[:remember_token] = { value:   remember_token,
                                 expires: 30.days.from_now.utc }
    
    # Este otro metodo coloca la fecha de expiracion en 20 años desde ahora (20.years.from_now.utc)
    # cookies.permanent[:remember_token] = remember_token
    
        
    # Esto guarda el atributo en la BD saltando los controles de nombre de usuario y contraseña
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    
    # Se crea un atributo con el usuario que acaba de iniciar sesion
    self.current_user = user
  end
  
  
  # Defino la asignacion usada en el procedimiento sign_in()
  def current_user=(user)
    @current_user = user
  end


  # Funcion para obtener el usaurio actual. Busca en la BD por medio del token guardado en la cookie.
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    
    # Esta asignacion especial invoca la funcion find_by solo si @current_user no esta definida.
    # Es basicamente la misma idea que cuando se usa "x += 1", que equivale a "x = x + 1"
    # Por mas informacion: http://ruby.railstutorial.org/chapters/sign-in-sign-out#sidebar-or_equals
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  
  # Permite saber si un usuario inicio sesion
  def signed_in?
    !current_user.nil?
  end
  
  
  # Para cerrar la sesion
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  
end
