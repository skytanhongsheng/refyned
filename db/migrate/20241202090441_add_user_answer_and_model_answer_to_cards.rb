class AddUserAnswerAndModelAnswerToCards < ActiveRecord::Migration[7.1]
  def change
    add_column :cards, :user_answer, :text
    add_column :cards, :model_answer, :text, null: false, default: ""
    remove_column :cards, :answer, :text
  end
end
