class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: %i[votable_id votable_type], message: 'Already voted' }

  validates :kind,
            presence: true,
            numericality: true,
            inclusion: { in: [-1, 1] }
end
