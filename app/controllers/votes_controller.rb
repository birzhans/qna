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
      render json: { kind: @vote.kind, vote_balance: @vote.votable_balance }
    else
      render json: @vote.errors.full_messages, status: :unprocessable_entity
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

    render json: { vote_balance: @votable.vote_balance }
  end

  private

  def check_existence
    vote = Vote.find_by(votable_id: params[:votable_id], user_id: current_user.id)
    render(json: 'Already voted', status: :unprocessable_entity) if vote
  end
end
