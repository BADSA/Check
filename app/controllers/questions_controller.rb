class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def new
    @cq = params[:curr].to_i + 1
    @question = Question.new
    render layout: false
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.save
    render layout:false,text:"Success"
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_with(@question)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :type, :choice1, :choice2, :choice3, :choice4, :right_answer,:test_id)
    end
end
