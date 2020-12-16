class AddCreationWizardCompleteToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :creation_wizard_complete, :boolean, default: false
  end
end
