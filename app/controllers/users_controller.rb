# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# III Tarea Programada
# Ruby on Rails/ Bootstrap/ Angular
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015


# Controller to handle the requests and views for the
# User model.

class UsersController < ApplicationController
    
  before_action :authenticate_user!
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.manager=true
    @user.save
  end

  def edit
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:title, :summary, :body)
  end
end