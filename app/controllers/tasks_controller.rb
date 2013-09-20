class TasksController < ApplicationController
  
  before_action :require_login
  
  #Agregada: si no estas logueado te lleva a loguearte antes de realizar una accion y si ya estas logueado te da el usuario
  def require_login
    if ! signed_in?
      flash[:error] = "No estas logueado. Debes estar registrado para acceder"
      redirect_to main_url
    else
      @usuario = User.find(current_user.id)
    end
  end
 
  def new
    @task = @usuario.tasks.new();
  end

  def create
    @task = @usuario.tasks.create(parametros())
    if @task.save()
      flash[:success] = "Tarea ingresada correctamente!!!"
      redirect_to tasks_path
    else
      flash[:error] = "No debe dejar campos sin llenar, intente nuevamente"
      render "new"
    end
  end

  def show
    @task = @usuario.tasks.find(params[:id])
  end

  def index
    @tasks = @usuario.tasks.all()
  end

  def edit
    @task = @usuario.tasks.find(params[:id])
  end

  def update
    @task = @usuario.tasks.find(params[:id])
    if @task.update(parametros())
      flash[:success] = "Tarea actualizada correctamente!!!"
      redirect_to tasks_path
    end
  end

  def destroy
    @usuario.tasks.find(params[:id]).destroy
    flash[:success] = "Tarea eliminada correctamente!!!"
    redirect_to tasks_path
  end
  
    private
    def parametros
        params.require(:task).permit(:date, :time_start, :time_end, :description)
    end
end
