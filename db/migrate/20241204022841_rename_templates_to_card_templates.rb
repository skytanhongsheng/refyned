class RenameTemplatesToCardTemplates < ActiveRecord::Migration[7.1]
  def change
    # rename tables
    rename_table :templates, :card_templates
    rename_table :curriculum_templates, :curriculum_card_templates

    # rename foreign key columns
    rename_column :cards, :template_id, :card_template_id
    rename_column :curriculum_card_templates, :template_id, :card_template_id
  end
end
