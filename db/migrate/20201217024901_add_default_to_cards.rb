class AddDefaultToCards < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sort_cards, :title, ''
    change_column_default :card_sort_cards, :description, ''
    change_column_default :card_sort_cards, :has_description, false
  end
end
