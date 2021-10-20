class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  enum kind: { like: 1, dislike: -1 }

  validate :author?

  def author?
     if user.id == votable.user_id
       errors.add(:user_id, "Author can't vote")
     end
  end

  validates :kind,
            presence: true,
            numericality: true,
            inclusion: { in: kinds.keys }

  after_create :update_votable_after_create
  before_destroy :update_votable_before_destroy

  def update_votable_after_create
    votable.update(vote_balance: votable.vote_balance += kind_before_type_cast)
  end

  def update_votable_before_destroy
    votable.update(vote_balance: votable.vote_balance -= kind_before_type_cast)
  end
end