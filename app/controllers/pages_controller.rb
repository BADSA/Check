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

=begin
  La fecha de expiracion sea mayor que la fecha actual.
  Usuario no los haya resuelto.
  No hayan sido creados por el usuario.
=end
  def index
    @tests2 = Test.all
    @tests = Array.new
    if user_signed_in?
      @tests2.each do |test|
        is_complete = TestAnswer.where(user_id:current_user.id,test_id:test.id,status:"complete")
        puts "======================"
        puts "its complete"
        puts is_complete
        puts "creado por el usuario"
        puts (test.user_id == current_user.id)
        puts "Tiempo expirado"
        puts test.ends_at.utc
        puts Time.now.utc
        puts test.ends_at.utc < Time.now.utc
        puts "======================"
        if (not ((is_complete!=nil) or (test.user_id == current_user.id) or (test.ends_at < Time.now)))
          @tests.push test
          puts "+++++++++++++++++++++++++++++++++"
          puts "Agregando"
          puts "+++++++++++++++++++++++++++++++++"
        end
      end
    else
      @tests = @tests2
    end
  end


  def newQuestion
    render layout: false
  end

end
