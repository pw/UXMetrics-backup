class AddDefaultToNameOnCardSorts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sorts, :name, ''
  end
end
