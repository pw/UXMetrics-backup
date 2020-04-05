class CreateTreeTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tree_tests do |t|
      t.string :name
      t.text :participant_instructions
      t.text :thank_you_message
      t.boolean :randomize_tree_order
      t.jsonb :tree
      t.boolean :randomize_task_order
      t.boolean :allow_skip

      t.timestamps
    end
  end
end
