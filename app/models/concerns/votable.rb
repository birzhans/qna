module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote_balance
    votes.sum(:kind)
  end
end
