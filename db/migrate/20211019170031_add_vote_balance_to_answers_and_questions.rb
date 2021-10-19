class AddVoteBalanceToAnswersAndQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :vote_balance, :integer, default: 0
    add_column :answers, :vote_balance, :integer, default: 0
  end
end
