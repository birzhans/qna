class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %w[new create]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      redirect_to @question, notice: "Body can't be blank."
    end
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy

    redirect_to answer.question, notice: 'Answer was successfully deleted.'
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
