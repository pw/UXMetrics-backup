class AddCurrentTreeIndexToTreeTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_tests, :current_tree_index, :integer
  end
end
