class AddFixedgroupsToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :fixedgroups, :text
  end
end
