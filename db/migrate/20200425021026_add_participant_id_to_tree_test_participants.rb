class AddParticipantIdToTreeTestParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_participants, :participant_id, :integer
  end
end
