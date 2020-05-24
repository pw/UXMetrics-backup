class CreateCardSortSorts < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sort_sorts do |t|
      t.references :card_sort, foreign_key: true
      t.references :card_sort_participant, foreign_key: true
      t.references :card_sort_group, foreign_key: true
      t.references :card_sort_card, foreign_key: true

      t.timestamps
    end
  end
end
