class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "answer_#{params[:question_id]}"
  end
end
