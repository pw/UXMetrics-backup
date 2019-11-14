class AddMergedgroupsToCardtest < ActiveRecord::Migration[5.2]
  def change
    add_column :cardtests, :mergedgroups, :json, null: false, default: []
  end
end
