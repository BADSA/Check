# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# III Tarea Programada
# Ruby on Rails/ Bootstrap/ Angular
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015


# Controller that takes control of some of the main pages of the
# application to display home, user profile.
class PagesController < ApplicationController

  def index
    test_answer = TestAnswer.where(user_id:current_user.id)
    #test_id status="complete"
    @tests = Test.all
  end


  def newQuestion
    render layout: false
  end

end
