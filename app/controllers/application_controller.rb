class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Incluyo este ayudante para controlar la sesion tanto en controladores como en vistas.
  # Por defecto, todos los ayudantes estan disponibles en las vistas, pero no en controladores,
  # por eso hay que incluirlo explicitamente.
  include SessionsHelper
end
