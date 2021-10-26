module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote_balance
    votes.sum(:kind)
  end

  def voted?(user)
    votes.find_by(user: user).present?
  end

  def voted_with_kind?(user, kind)
    votes.find_by(user: user, kind: kind).present?
  end
end
