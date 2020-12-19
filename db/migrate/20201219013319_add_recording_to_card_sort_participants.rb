class AddRecordingToCardSortParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sort_participants, :recording, :text
  end
end
