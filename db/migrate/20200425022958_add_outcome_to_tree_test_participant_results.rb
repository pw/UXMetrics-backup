class AddOutcomeToTreeTestParticipantResults < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_participant_results, :outcome, :string
  end
end
