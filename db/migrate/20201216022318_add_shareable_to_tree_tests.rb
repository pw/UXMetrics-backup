class AddShareableToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :shareable, :boolean, default: true
  end
end
