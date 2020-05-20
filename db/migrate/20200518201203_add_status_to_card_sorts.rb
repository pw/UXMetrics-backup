class AddStatusToCardSorts < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sorts, :status, :string, default: 'draft'
  end
end
