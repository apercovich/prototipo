class TasksController < ApplicationController
   
  def new
    @task = Task.new();
  end

  def create
    u = User.find(current_user.id)
    u.tasks.create(parametros())
    
    flash[:success] = "Tarea ingresada correctamente!!!"
    redirect_to tasks_path
  end

  def show
    u = User.find(current_user.id)
    @task = u.tasks.find(params[:id])
  end

  #Muestro todas las tareas de un usuario
  def index
    u = User.find(current_user.id)
    @tasks = u.tasks.all()
  end

  def edit
    u = User.find(current_user.id)
    @task = u.tasks.find(params[:id])
  end

  def update
    u = User.find(current_user.id)
    @task = u.tasks.find(params[:id])
    
    if @task.update(parametros())
      flash[:success] = "Tarea actualizada correctamente!!!"
      redirect_to tasks_path
    end
  end

  def destroy
    u = User.find(current_user.id)
    u.tasks.find(params[:id]).destroy
    flash[:success] = "Tarea eliminada correctamente!!!"
    redirect_to tasks_path
  end
  
    private
    def parametros
        params.require(:task).permit(:date, :time_start, :time_end, :description)
    end
end
