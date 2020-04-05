class AddPathToTreeTestParticipantResult < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_participant_results, :path, :string
  end
end
