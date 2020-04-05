class RemoveCorrectChoiceOnTreeTestTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tree_test_tasks, :correct_choice
  end
end
