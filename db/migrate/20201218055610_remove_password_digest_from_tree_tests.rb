class RemovePasswordDigestFromTreeTests < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_tests, :password_digest, :string
  end
end
