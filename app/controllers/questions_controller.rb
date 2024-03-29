class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %w[index show]
  before_action :set_question, only: %w[show update destroy]
  before_action :authorize!, only: %w[update destroy]
  after_action :publish_question, only: %w[create]

  def index
    @questions = Question.all
    @count = Question.count
  end

  def show
    @answer = Answer.new
    @answer.links.new
    @best_answer = @question.best_answer
    @answers = @question.answers_without_best
    gon.question_id = @question.id
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
    if @question.update(question_params.except(:files)) && question_params[:files].present?
      question_params[:files].each do |file|
        @question.files.attach(file)
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
    redirect_to questions_path, notice: 'restricted access' if current_user.not_author_of? @question
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                                    links_attributes: %i[id name url _destroy],
                                                    reward_attributes: %i[id name image _destroy])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast(
      'questions_channel',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question }
      )
    )
  end
end
