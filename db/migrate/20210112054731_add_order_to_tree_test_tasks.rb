class AddOrderToTreeTestTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_test_tasks, :order, :integer
  end
end
