class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.boolean :bookmarked, null: false, default: false
      t.boolean :correct, null: true
      t.text :instruction, null: false
      t.text :context, null: true
      t.text :answer, null: false
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
