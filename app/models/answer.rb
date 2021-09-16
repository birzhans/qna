class Answer < ApplicationRecord
  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :question
  belongs_to :user

  accepts_nested_attributes_for :links, reject_if: :all_blank

  has_many_attached :files

  validates :body, presence: true

  def best?
    id == question.best_answer_id
  end
end
