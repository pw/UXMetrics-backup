class RemoveCorrectPathFromTreeTestTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_test_tasks, :correct_path, :string
  end
end
