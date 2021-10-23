class Question < ApplicationRecord
  include Votable
  
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  has_one :reward, dependent: :destroy

  belongs_to :best_answer, class_name: 'Answer', optional: true
  belongs_to :user

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  validates :title, :body, presence: true

  def answers_without_best
    best_answer_id ? answers.where('id != ?', best_answer_id) : answers
  end

  def reward_user(user_id)
    reward.update(user_id: user_id) if reward
  end
end
