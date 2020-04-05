class CreateTreeTestParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :tree_test_participants do |t|
      t.references :tree_test, foreign_key: true

      t.timestamps
    end
  end
end
