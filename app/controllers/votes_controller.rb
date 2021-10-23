class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_votable, only: [:create]

  def create
    @vote = Vote.new(
      votable: @votable,
      user_id: current_user.id,
      kind: params[:kind].to_i
    )

    if @vote.save
      render json: {
        kind: @vote.kind,
        vote_balance: @votable.vote_balance,
        type: @vote.votable_type,
        id: @vote.votable_id
      }
    else
      render json: {
        type: @vote.votable_type,
        id: @vote.votable_id,
        messages: @vote.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find_by(
              votable_id: params[:votable_id],
              votable_type: params[:votable_type],
              user: current_user
            )
    @votable = @vote.votable
    @vote.destroy

    render json: {
      vote_balance: @votable.id,
      type: @vote.votable_type,
      id: @vote.votable_id
    }
  end

  def set_votable
    @votable = Object.const_get(params[:votable_type]).find(params[:votable_id])
  end
end
