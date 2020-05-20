class RemoveCardIdFromCardSortCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :card_sort_cards, :card_id, :integer
  end
end
