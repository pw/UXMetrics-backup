class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.text :name
      t.references :cardtest, foreign_key: true
      t.integer :order
      

      t.timestamps
    end
  end
end
