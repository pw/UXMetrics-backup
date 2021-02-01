class AddSortToCardSortParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sort_participants, :sort, :string
  end
end
