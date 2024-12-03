class CreateCurriculumTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :curriculum_templates do |t|
      t.references :template, null: false, foreign_key: true
      t.references :curriculum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
