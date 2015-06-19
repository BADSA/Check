# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# IV Tarea Programada
# Ruby on Rails/ Bootstrap/ TDD y BDD
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015

class Question < ActiveRecord::Base
  belongs_to :test
  def add_attrs(attrs)
    attrs.each do |var, value|
      class_eval { attr_accessor var }
      instance_variable_set "@#{var}", value
    end
  end
=begin
  Active Record Models can inherit from a table through the attribute :type,
  setting the inheritance_column to nil removes that attribute allowing you to have a database column named type
=end
  self.inheritance_column = nil
end
