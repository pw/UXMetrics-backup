class ChangeDefaultOfLegacyOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :legacy, false
  end
end
