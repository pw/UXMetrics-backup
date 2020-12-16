class AddShareableToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :shareable, :boolean, default: true
  end
end
