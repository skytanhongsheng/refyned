class AddColumnsToLesson < ActiveRecord::Migration[7.1]
  def change
    add_column :lessons, :order, :integer
    add_column :lessons, :status, :string
  end
end
