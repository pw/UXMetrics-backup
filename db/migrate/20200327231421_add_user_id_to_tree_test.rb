class AddUserIdToTreeTest < ActiveRecord::Migration[5.2]
  def change
    add_reference :tree_tests, :user, foreign_key: true
  end
end
