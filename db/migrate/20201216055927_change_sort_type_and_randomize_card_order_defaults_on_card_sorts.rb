class ChangeSortTypeAndRandomizeCardOrderDefaultsOnCardSorts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sorts, :sort_type, 'open'
    change_column_default :card_sorts, :randomize_card_order, false
  end
end
