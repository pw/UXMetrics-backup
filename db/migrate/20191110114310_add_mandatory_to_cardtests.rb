class AddMandatoryToCardtests < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :mandatory, :boolean, null: false, default: true
  end
end
