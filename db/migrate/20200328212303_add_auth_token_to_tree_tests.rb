class AddAuthTokenToTreeTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tree_tests, :auth_token, :string
  end
end
