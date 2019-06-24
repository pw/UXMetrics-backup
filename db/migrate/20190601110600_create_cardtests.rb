class CreateCardtests < ActiveRecord::Migration[5.2]
  def change
    create_table :cardtests do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :auth_token
      t.boolean :status
      t.string :uid






      t.timestamps
    end

    add_index :cardtests, :auth_token, unique: true
    add_index :cardtests, :uid, unique: true
  end
end
