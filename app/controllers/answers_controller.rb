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
    if @answer.update(answer_params.except(:files)) && answer_params[:files].present?
      answer_params[:files].each do |file|
        @answer.files.attach(file)
      end
    end
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
      @question.reward_user(@answer.user_id)
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
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def authorize!
    redirect_to questions_path, notice: 'restricted access' if current_user.not_author_of? @answer
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[name url])
  end
end
