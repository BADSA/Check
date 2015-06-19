class QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @question_answers = QuestionAnswer.all
    respond_with(@question_answers)
  end

  def show
    respond_with(@question_answer)
  end

  def new
    @question_answer = QuestionAnswer.new
    respond_with(@question_answer)
  end

  def edit
  end

  def create
    @question_answer = QuestionAnswer.new(question_answer_params)
    @question_answer.save
    respond_with(@question_answer)
  end

  def update
    @question_answer.update(question_answer_params)
    respond_with(@question_answer)
  end

  def destroy
    @question_answer.destroy
    respond_with(@question_answer)
  end

  private
    def set_question_answer
      @question_answer = QuestionAnswer.find(params[:id])
    end

    def question_answer_params
      params.require(:question_answer).permit(:choice)
    end
end
