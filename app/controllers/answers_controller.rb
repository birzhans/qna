class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %w[new create]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      redirect_to @question, notice: "Body can't be blank."
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
