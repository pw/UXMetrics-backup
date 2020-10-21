class CreatePasswordResets < ActiveRecord::Migration[6.0]
  def change
    create_table :password_resets do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
    add_index :password_resets, :token, unique: true
  end
end
