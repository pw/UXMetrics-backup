class RemoveGroupIdFromCardSortGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :card_sort_groups, :group_id, :integer
  end
end
