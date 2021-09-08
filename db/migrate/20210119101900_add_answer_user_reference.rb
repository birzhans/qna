class AddAnswerUserReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user, null: false
  end
end
