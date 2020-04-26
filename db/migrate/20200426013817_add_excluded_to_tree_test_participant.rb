class AddExcludedToTreeTestParticipant < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_test_participants, :excluded, :boolean, default: false
  end
end
