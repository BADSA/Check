# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# IV Tarea Programada
# Ruby on Rails/ Bootstrap/ TDD y BDD
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015

class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy,:score]

  respond_to :html

  def index
    @tests = tests_by_status
    render layout: false
  end

  def show
    @isAnswered = false
    @questions = @test.questions
    ta = TestAnswer.find_by( test_id: params[:id],user_id:current_user.id)
    if (ta != nil)
      user_answers = ta.question_answers
      @questions.zip(user_answers).each do |q,ua|

        isChecked1 = is_checked(ua.choice,"choice1")
        isChecked2 = is_checked(ua.choice,"choice2")
        isChecked3 = is_checked(ua.choice,"choice3")
        isChecked4 = is_checked(ua.choice,"choice4")

        q.add_attrs({check1:isChecked1})
        q.add_attrs({check2:isChecked2})
        q.add_attrs({check3:isChecked3})
        q.add_attrs({check4:isChecked4})
      end
      @isAnswered = true
    end

    respond_with(@test)
  end

  def new
    @test = Test.new
    respond_with(@test)
  end

  def edit
  end

  def create
    @test = Test.new(test_params)
    @test.save
    render layout:false,text:@test.id
  end

  def update
    @test.update(test_params)
    render layout:false, text:"Success"
  end

  def destroy
    @test.destroy
    respond_with(@test)
  end


  def score
    # Array with user answers
    user_answers = params[:answers]

    questions = @test.questions
    total_questions = @test.questions_amount
    rights = 0

    # To compare user answers with right answers
    user_answers.zip(questions).each do |u_answer,question|
      rights += 1 if u_answer == question.right_answer
    end

    score = (rights*100) / total_questions
    flash[:success] = "Examen realizado - Nota obtenida: "+score.to_s
    render layout:false, text: score
  end



  private
    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:name, :description, :begins_at, :ends_at,:user_id,:questions_amount)
    end

    def is_checked(user_answers,opt)
      answers = user_answers.split(",")
      answers.each do |a|
        if opt==a
          return "checked"
        end
      end
      return ""
    end

    def tests_by_status
      if params[:status] != "NULL"
        query = {test_answers: { user_id: current_user.id, status: params[:status]}}
        tests = Test.find TestAnswer.joins(:test).where(query).map(&:test_id)
        tests
      else
        Test.where( user_id: current_user.id )
      end
    end
end
