# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# IV Tarea Programada
# Ruby on Rails/ Bootstrap/ TDD y BDD
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015

class TestAnswer < ActiveRecord::Base
  belongs_to :test
  belongs_to :user
  has_many :question_answers,dependent: :destroy
end
