# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.delete_all
Test.delete_all
Question.delete_all

user = User.create([
                       {id:1 ,email:'badsa@badsacorp.com',name:'badsa',manager:true,password:'12345678'},
                       {id:2 ,email:'daniel@badsacorp.com',name:'daniel',manager:false,password:'12345678'},
                       {id:3 ,email:'alonso@badsacorp.com',name:'alonso',manager:false,password:'12345678'},
                       {id:4 ,email:'bayron@badsacorp.com',name:'bayron',manager:false,password:'12345678'},
                       {id:5 ,email:'sebas@badsacorp.com',name:'sebas',manager:false,password:'12345678'}
                   ])

test = Test.create([
                      {id:1,name:"Estadistica",description:"Segundo examen de estadistica II semestre 2015 - Sede interuniversitaria de Alajuela",begins_at:Time.now,ends_at:Time.now,user_id:1,questions_amount:2},
                      {id:2,name:"Programacion orientada a objetos",description:"Los siguientes enunciados corresponden al primer examen de Programacion Orientada a Objetos con un peso de 20% sobre la nota del curso",begins_at:Time.now,ends_at:Time.now,user_id:2,questions_amount:4}
                   ])

questions = Question.create([
                                {title:"Cual de estos es el nombre de una distribucion valida?",type:"radio",choice1:"Naur",choice2:"Binomial",choice3:"Holman",choice4:"Caisse",right_answer:"choice2",test_id:1},
                                {title:"Como es determinado el alpha en un enunciado?",type:"radio",choice1:"Por el tipo de distribucion",choice2:"Por ley de morgan",choice3:"Por la inombal",choice4:"Por el porcentaje de confianza",right_answer:"choice4",test_id:1},

                                {title:"Que significa POO?",type:"radio",choice1:"Programacion orientada a metodos",choice2:"Programacion orientada Oquichi",choice3:"Programacion orientada a Objetos",choice4:"Programacion orientada a Hologramas",right_answer:"choice3",test_id:2},
                                {title:"Tecnicas de POO",type:"checkbox",choice1:"Herencia",choice2:"Backtracking",choice3:"Encapsulamiento",choice4:"Polimorfismo",right_answer:"choice1,choice3,choice4",test_id:2},
                                {title:"Cual es un lenguaje orientado a objetos",type:"radio",choice1:"Prolog",choice2:"Scheme",choice3:"Java",choice4:"C",right_answer:"choice3",test_id:2},
                                {title:"En que consiste la herencia?",type:"checkbox",choice1:"Es la facilidad mediante la cual una clase hereda cada uno de los atributos y operaciones a otra.",choice2:"Entidad provista de un conjunto de propiedades o atributos.",choice3:"Algoritmo asociado a un objeto (o a una clase de objetos), cuya ejecución se desencadena tras la recepción de un mensaje.",choice4:"Es un suceso en el sistema",right_answer:"choice1",test_id:2}

                            ])