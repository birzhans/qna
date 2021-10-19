class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :type,
            presence: true,
            numericality: true,
            inclusion: { in: [0, 1] }
end
