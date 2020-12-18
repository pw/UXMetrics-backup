class RemoveShareableFromTreeTests < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_tests, :shareable, :boolean
  end
end
