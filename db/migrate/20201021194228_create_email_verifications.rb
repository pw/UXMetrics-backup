class CreateEmailVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :email_verifications do |t|
      t.references :user
      t.string :token

      t.timestamps
    end
    add_index :email_verifications, :token, unique: true
  end
end
