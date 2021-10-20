class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_existence, only: [:create]

  def create
    @vote = Vote.new(
      votable_id: params[:votable_id],
      votable_type: params[:votable_type],
      user_id: current_user.id,
      kind: params[:kind].to_i
    )

    if @vote.save
      render json: @vote
    else
      render json: @vote.errors.full_messages
    end
  end

  def destroy
    @vote = Vote.find_by(params[:id])
    @vote.destroy
  end

  private

  def check_existence
    vote = Vote.find_by(votable_id: params[:votable_id], user_id: current_user.id)
    redirect_to(vote.votable, notice: 'Already voted') if vote
  end
end
