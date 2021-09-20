class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  before_action :set_question, only: %w[show update destroy]
  before_action :authorize!, only: %w[update destroy]

  def index
    @questions = Question.all
    @count = Question.count
  end

  def show
    @answer = Answer.new
    @answer.links.new
    @best_answer = @question.best_answer
    @answers = @question.answers_without_best
  end

  def new
    @question = current_user.questions.new
    @question.links.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params.except(:files))
      if question_params[:files].present?
        question_params[:files].each do |file|
          @question.files.attach(file)
        end
      end
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully deleted.'
  end

  private

  def set_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def authorize!
    if current_user.not_author_of? @question
      redirect_to questions_path, notice: 'restricted access'
    end
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end
end
