class AddCreationStepToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :creation_step, :integer, default: 1
  end
end
