class CreateCardSorts < ActiveRecord::Migration[5.2]
  def change
    create_table :card_sorts do |t|
      t.string :name
      t.string :logo_key
      t.text :participant_instructions
      t.text :thank_you_message
      t.string :sort_type
      t.boolean :randomize_card_order
      t.string :auth_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
