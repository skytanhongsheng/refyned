class CreateCurricula < ActiveRecord::Migration[7.1]
  def change
    create_table :curricula do |t|
      t.string :title, null: false
      t.text :purpose, null: false
      t.string :duration, null: false
      t.text :context, null: false
      t.references :language, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
