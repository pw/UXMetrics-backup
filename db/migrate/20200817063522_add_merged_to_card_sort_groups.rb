class AddMergedToCardSortGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_groups, :merged, :boolean, default: false
  end
end
