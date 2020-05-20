class AddOrderToCardSortCards < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_cards, :order, :integer
  end
end
