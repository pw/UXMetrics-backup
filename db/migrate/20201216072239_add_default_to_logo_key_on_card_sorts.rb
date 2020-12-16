class AddDefaultToLogoKeyOnCardSorts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sorts, :logo_key, ''
  end
end
