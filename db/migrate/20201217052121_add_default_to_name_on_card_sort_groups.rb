class AddDefaultToNameOnCardSortGroups < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sort_groups, :name, ''
  end
end
