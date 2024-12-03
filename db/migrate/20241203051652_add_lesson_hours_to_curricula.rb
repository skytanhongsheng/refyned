class AddLessonHoursToCurricula < ActiveRecord::Migration[7.1]
  def change
    add_column :curricula, :lesson_hours, :integer, default: 1
  end
end
