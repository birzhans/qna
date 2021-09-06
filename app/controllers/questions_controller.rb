class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  def index
    @questions = Question.all
    @count = Question.count
  end

  def show
    @answer = Answer.new
    @best_answer = question.best_answer
    @answers = question.answers.where.not(id: @question.best_answer_id)
  end

  def new; end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    question.update(question_params)
  end

  def destroy
    question.destroy
    redirect_to questions_path, notice: 'Question was successfully deleted.'
  end

  def best_answer
    @previous_best_answer = question.best_answer
    @best_answer = Answer.find(params[:answer_id])
    question.update(best_answer_id: @best_answer.id)
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
