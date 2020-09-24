class AddLegacyFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :legacy, :boolean, default: true
  end
end
