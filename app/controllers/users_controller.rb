class UsersController < ApplicationController

  # Antes de mostrar la pantalla de creación
  def new
    @user = User.new()
  end
  
  # Guardar el objeto
  def create
    @user = User.new(user_signup_params())
    @user.role = UserRole.find(params[:user][:role_id]);
    @user.state = UserState.find(UserState::ID_REGISTRADO);
    
    if @user.save()
      # Inicio sesion automaticamente
      sign_in(@user)
      
      Mailsender.newUser(@user).deliver()
      
      flash[:success] = "Sesión iniciada correctamente!!!"
      redirect_to @user
      
    else
      render "new"
    end
  end
  
  # Antes de mostrar los datos de un objeto
  def show
    @user = User.find(params[:id])
  end
  
  # Listar todos los objetos de este tipo
  def index
    @users = User.all()
  end
  
  # Cargar un objeto para edición
  def edit
    @user = User.find(params[:id])
  end
  
  # Guardar modificaciones a un objeto
  def update
    @user = User.find(params[:id])
    
    if @user.update(params.require(:user).permit(:name, :email, :role))
      redirect_to @user
    else
      render "edit"
    end
  end
  
  
  # Antes de mostrar la página para crear una nueva contraseña
  def pageResetPassword
    @user = User.new()
    render "resetPassword"
  end
  
  # Crea la nueva contraseña y la envía por email
  def confirmResetPassword
    @user = User.find_by(email: params[:user][:email].downcase)
    
    if not @user
      @user = User.new()
      flash.now[:error] = "No existe un usuario registrado con ese correo"
      render "resetPassword"
      
    else
      # Genero contraseña alfa-numérica de 6 dígitos
      charsMap = [('a'..'z'), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
      newPassword = (0...6).map{ charsMap[rand(charsMap.length)] }.join
      
      if not @user.update(:password => newPassword, :password_confirmation => newPassword)
        flash.now[:error] = "Ocurrió un error al guardar la nueva contraseña"
        render "resetPassword"
      else
        Mailsender.resetPassword(@user).deliver()
        
        flash[:success] = "Se envió un correo con la nueva contraseña: " + newPassword
        redirect_to root_url
      end
    end
  end
  
  
  # Eliminar un objeto
  def destroy
    @user = User.find(params[:id])
    @user.destroy()
    redirect_to users_path
  end
  

  #Define los parámetros que se toman en cuenta al registrar un usuario  
  private
    def user_signup_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
