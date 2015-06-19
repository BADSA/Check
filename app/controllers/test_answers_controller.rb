class TestAnswersController < ApplicationController
  before_action :set_test_answer, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @test_answers = TestAnswer.all
    respond_with(@test_answers)
  end

  def show
    respond_with(@test_answer)
  end

  def new
    @test_answer = TestAnswer.new
    respond_with(@test_answer)
  end

  def edit
  end

  def create
    @test_answer = TestAnswer.new(test_answer_params)
    @test_answer.save
    render layout:false,text:@test_answer.id
  end

  def update
    @test_answer.update(test_answer_params)
    respond_with(@test_answer)
  end

  def destroy
    @test_answer.destroy
    respond_with(@test_answer)
  end


  def save
    # Array with user answers
    user_answers = params[:answers]

    cnt = 1
    user_answers.each do |user_answer|
      qa = QuestionAnswer.find_by( test_answer_id: params[:id],question_number:cnt)
      p qa
      if qa!=nil
        qa.update(choice:user_answer,test_answer_id:params[:id],question_number:cnt)
      else
        QuestionAnswer.create(choice:user_answer,test_answer_id:params[:id],question_number:cnt)
      end
      cnt += 1
    end
    flash[:success] = "Guardado correctamente a las " + Time.now.strftime("%d/%m/%y %I:%M:%S %P")
    render layout:false, text: 'Success'
  end




  def find
    ta = TestAnswer.find_by( test_id: params[:testID],user_id:params[:userID])
    test_id = 'no'
    if (ta != nil)
      test_id = ta.id
    end
    render layout: false, text: test_id
  end


  private
    def set_test_answer
      @test_answer = TestAnswer.find(params[:id])
    end

    def test_answer_params
      params.require(:test_answer).permit(:status, :test_id,:user_id)
    end

end
