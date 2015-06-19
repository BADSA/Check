# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# IV Tarea Programada
# Ruby on Rails/ Bootstrap/ TDD y BDD
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015

class Test < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :user
  def add_attrs(attrs)
    attrs.each do |var, value|
      class_eval { attr_accessor var }
      instance_variable_set "@#{var}", value
    end
  end
end
