class UsersController < ApplicationController

  #Antes de mostrar la pantalla de creacion
  def new
    @user = User.new()
  end
  
  #Guardar el objeto
  def create
    @user = User.new(user_signup_params())
    @user.role = UserRole.find(params[:user][:role_id]);
    @user.state = UserState.find(UserState::ID_REGISTRADO);
    
    if @user.save()
      # Inicio sesion automaticamente
      sign_in(@user)
      flash[:success] = "Sesión iniciada correctamente!!!"
      redirect_to @user
      
    else
      render "new"
    end
  end
  
  #Antes de mostrar los datos de un objeto
  def show
    @user = User.find(params[:id])
  end
  
  #Listar todos los objetos de este tipo
  def index
    @users = User.all()
  end
  
  #Cargar un objeto para edicion
  def edit
    @user = User.find(params[:id])
  end
  
  #Guardar modificaciones a un objeto
  def update
    @user = User.find(params[:id])
    
    if @user.update(params.require(:user).permit(:name, :email, :role))
      redirect_to @user
    else
      render "edit"
    end
  end
  
  #Eliminar un objeto
  def destroy
    @user = User.find(params[:id])
    @user.destroy()
    redirect_to users_path
  end
  

  #Define los parametros que se toman en cuenta al registrar un usuario  
  private
    def user_signup_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
    end

end
