class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.string :name
      t.text :data
      t.references :cardtest, foreign_key: true

      t.timestamps
    end
  end
end
