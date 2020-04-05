class AddCorrectChoiceToTreeTestTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_tasks, :correct_choice, :integer
    add_column :tree_test_tasks, :correct_path, :string
  end
end
