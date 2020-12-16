class AddPasswordDigestToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :password_digest, :string
  end
end
