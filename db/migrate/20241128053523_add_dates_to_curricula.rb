class AddDatesToCurricula < ActiveRecord::Migration[7.1]
  def change
    remove_column :curricula, :duration, :string
    add_column :curricula, :start_date, :date, null: false
    add_column :curricula, :end_date, :date, null: false
  end
end
