class AddPasswordDigestToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :password_digest, :string
  end
end
