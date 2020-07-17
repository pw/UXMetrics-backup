class AddDefaultToExcludedOnCardSortParticipants < ActiveRecord::Migration[5.2]
  def change
    change_column :card_sort_participants, :excluded, :boolean, default: false
  end
end
