class AddHasDescriptionToCardSortCards < ActiveRecord::Migration[5.2]
  def change
    add_column :card_sort_cards, :has_description, :boolean
  end
end
