class RemoveTaskNumberFromTreeTestTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_test_tasks, :task_number, :integer
  end
end
