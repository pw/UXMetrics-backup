class CreateCardSortCards < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sort_cards do |t|
      t.string :title
      t.text :description
      t.integer :card_id
      t.references :card_sort, foreign_key: true

      t.timestamps
    end
  end
end
