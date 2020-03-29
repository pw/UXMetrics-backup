class AddIndexToAuthTokenOnTreeTests < ActiveRecord::Migration[5.2]
  def change
    add_index(:tree_tests, :auth_token)
  end
end
