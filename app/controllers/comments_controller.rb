class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :publish_comment

  def create
    @commentable = Object.const_get(params[:comment][:commentable_type]).find(params[:comment][:commentable_id])
    @comment = Comment.new(comment_params)
    @comment.commentable = @commentable
    @comment.user = current_user
    @comment.save
  end

  private

  def publish_comment
    question_id = if @comment.commentable_type == 'Question'
                    @commentable.id
                  else
                    @commentable.question_id
                  end

    ActionCable.server.broadcast(
      "comments_#{question_id}",
      {
        comment: @comment,
        email: @comment.user.email
      }
    )
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
