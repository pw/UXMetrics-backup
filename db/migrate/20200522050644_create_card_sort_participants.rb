class CreateCardSortParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sort_participants do |t|
      t.references :card_sort, foreign_key: true
      t.integer :time
      t.boolean :excluded
      t.integer :participant_id

      t.timestamps
    end
  end
end
