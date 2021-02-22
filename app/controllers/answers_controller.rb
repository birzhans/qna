class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %w[new create]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy

    redirect_to answer.question, notice: 'Answer was successfully deleted.'
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
