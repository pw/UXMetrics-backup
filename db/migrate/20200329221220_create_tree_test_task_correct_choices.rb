class CreateTreeTestTaskCorrectChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :tree_test_task_correct_choices do |t|
      t.integer :node
      t.string :path
      t.references :tree_test_task, foreign_key: true

      t.timestamps
    end
  end
end
