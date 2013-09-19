class TasksController < ApplicationController
  
  #Para no repetir codigo en los siguientes metodos 
  before_filter :obtener_usuario, :only => [:create, :show, :index, :edit, :update, :destroy]
  
  #Agregada
  def obtener_usuario
    @usuario = User.find(current_user.id)
  end
 
  def new
    @task = Task.new();
  end

  def create
    @usuario.tasks.create(parametros())
    if ! @usuario.errors
      flash[:success] = "Tarea ingresada correctamente!!!"
      redirect_to tasks_path
    else
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
