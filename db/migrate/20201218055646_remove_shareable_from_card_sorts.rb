class RemoveShareableFromCardSorts < ActiveRecord::Migration[6.0]
  def change
    remove_column :card_sorts, :shareable, :boolean
  end
end
