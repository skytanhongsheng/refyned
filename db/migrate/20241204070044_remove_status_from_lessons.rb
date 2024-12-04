class RemoveStatusFromLessons < ActiveRecord::Migration[7.1]
  def change
    remove_column :lessons, :status, :string
  end
end
