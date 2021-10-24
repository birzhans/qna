class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_votable, only: %w(create destroy)

  def create
    @vote = Vote.new(votable: @votable, user: current_user, kind: params[:kind].to_i)
    if @vote.save
      render json: json_response
    else
      render json: {
        type: @vote.votable_type,
        id: @vote.votable_id,
        messages: @vote.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find_by(votable: @votable, user: current_user)
    @vote.destroy

    render json: json_response
  end

  private

  def json_response
    { kind: @vote.kind, vote_balance: @votable.vote_balance,
      type: @vote.votable_type, id: @vote.votable_id }
  end

  def set_votable
    @votable = Object.const_get(params[:votable_type]).find(params[:votable_id])
  end
end
