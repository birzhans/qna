class AddAuthorToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user, null: false
  end
end
