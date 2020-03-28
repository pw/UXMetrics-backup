class CreateTreeTestTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tree_test_tasks do |t|
      t.references :tree_test
      t.text :instructions
      t.jsonb :correct_choice

      t.timestamps
    end
  end
end
