class AddMergedGroupIdToCardSortGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_groups, :merged_group_id, :bigint
  end
end
