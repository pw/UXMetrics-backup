class AddDefaultToLogoKeyOnTreeTests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tree_tests, :logo_key, ''
  end
end
