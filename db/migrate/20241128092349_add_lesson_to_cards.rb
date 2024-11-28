class AddLessonToCards < ActiveRecord::Migration[7.1]
  def change
    add_reference :cards, :lesson, null: false, foreign_key: true
  end
end
