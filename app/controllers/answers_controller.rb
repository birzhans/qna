class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %w[new create]
  before_action :set_answer, only: %w[destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    flash[:notice] = "Your answer #{@answer.body} successfully created."
  end

  def destroy
    question = @answer.question
    @answer.destroy

    redirect_to question, notice: 'Answer was successfully deleted.'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
