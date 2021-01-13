class RemoveCurrentTreeIndexFromTreeTests < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_tests, :current_tree_index, :integer
  end
end
