class AddOutroToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :outro, :text
  end
end
