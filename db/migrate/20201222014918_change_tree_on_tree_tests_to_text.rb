class ChangeTreeOnTreeTestsToText < ActiveRecord::Migration[6.0]
  def change
    change_column :tree_tests, :tree, :text
  end
end
