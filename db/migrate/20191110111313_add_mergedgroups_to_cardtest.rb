class AddMergedgroupsToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :mergedgroups, :string, array: true, default: []
  end
end
