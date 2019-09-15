class AddIntroToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :intro, :text
  end
end
