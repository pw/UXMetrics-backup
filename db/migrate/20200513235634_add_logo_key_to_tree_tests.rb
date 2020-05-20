class AddLogoKeyToTreeTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_tests, :logo_key, :string
  end
end
