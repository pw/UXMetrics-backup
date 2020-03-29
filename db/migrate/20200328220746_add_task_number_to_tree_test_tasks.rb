class AddTaskNumberToTreeTestTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_tasks, :task_number, :integer
  end
end
