class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  belongs_to :best_answer, class_name: 'Answer', optional: true
  belongs_to :user

  has_many_attached :files

  validates :title, :body, presence: true

  def answers_without_best
    answers.where('id != ?', best_answer_id)
  end
end
