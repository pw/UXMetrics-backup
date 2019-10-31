class AddTesttypeToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :testtype, :string, default: "open", null: false
  end
end
