class RemoveLegacyFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :legacy, :boolean
  end
end
