class RemovePasswordDigestFromCardSorts < ActiveRecord::Migration[6.0]
  def change
    remove_column :card_sorts, :password_digest, :string
  end
end
