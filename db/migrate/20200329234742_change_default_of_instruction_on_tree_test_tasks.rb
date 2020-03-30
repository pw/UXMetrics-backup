class ChangeDefaultOfInstructionOnTreeTestTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:tree_test_tasks, :instructions, from: nil, to: 'Task instructions (e.g. "Imagine that you want to update your credit card details. Where would you find that?")')
  end
end
