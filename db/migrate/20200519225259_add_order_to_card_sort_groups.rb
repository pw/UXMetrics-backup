class AddOrderToCardSortGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_groups, :order, :integer
  end
end
