class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  before_action :authorize!, only: %w[update destroy]

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

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  def authorize!
    if current_user.not_author_of? question
      redirect_to questions_path, notice: 'restricted access'
    end
  end

  helper_method :question

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end
end
