class CreateCardSortGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sort_groups do |t|
      t.string :name
      t.integer :group_id
      t.references :card_sort, foreign_key: true

      t.timestamps
    end
  end
end
