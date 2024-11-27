class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.decimal :score, null: false, default: 0
      t.decimal :progress, null: false, default: 0
      t.references :curriculum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
