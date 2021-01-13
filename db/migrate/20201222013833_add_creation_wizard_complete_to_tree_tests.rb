class AddCreationWizardCompleteToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :creation_wizard_complete, :boolean, default: false
  end
end
