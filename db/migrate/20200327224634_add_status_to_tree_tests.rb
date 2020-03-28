class AddStatusToTreeTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_tests, :status, :string, default: 'draft'
  end
end
