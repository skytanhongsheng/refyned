class RemoveLessonColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :lessons, :score, :decimal
    remove_column :lessons, :progress, :decimal
  end
end
