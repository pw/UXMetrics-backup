class AddPreMergeGroupIdToCardSortSorts < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_sorts, :pre_merge_group_id, :bigint
  end
end
