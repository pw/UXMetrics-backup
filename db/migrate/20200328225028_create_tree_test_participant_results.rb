class CreateTreeTestParticipantResults < ActiveRecord::Migration[5.2]
  def change
    create_table :tree_test_participant_results do |t|
      t.references :tree_test_participant, foreign_key: true
      t.references :tree_test_task, foreign_key: true
      t.integer :time
      t.integer :choice
      t.boolean :skip

      t.timestamps
    end
  end
end
