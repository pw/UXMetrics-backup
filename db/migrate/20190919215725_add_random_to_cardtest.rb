class AddRandomToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :random, :boolean
  end
end
