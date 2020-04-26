class AddExcludedToTreeTestParticipantResults < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_participant_results, :excluded, :boolean, default: false
  end
end
