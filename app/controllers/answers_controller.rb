class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %w[new create]
  before_action :set_answer, only: %w[update destroy best]
  before_action :authorize!, only: %w[update destroy]

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    flash[:notice] = "Your answer #{@answer.body} successfully created."
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
    flash[:notice] = "Your answer #{@answer.body} successfully updated."
  end

  def destroy
    question = @answer.question
    @answer.destroy

    flash[:notice] = 'Answer was successfully deleted.'
  end

  def best
    if current_user.author_of?(@answer.question)
      @question = @answer.question
      @previous_best_answer = @question.best_answer
      @question.update(best_answer_id: @answer.id)
    else
      redirect_to questions_path, notice: 'restricted access'
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def authorize!
    if current_user.not_author_of? @answer
      redirect_to questions_path, notice: 'restricted access'
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
