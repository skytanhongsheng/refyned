class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.text :content, null: false
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
