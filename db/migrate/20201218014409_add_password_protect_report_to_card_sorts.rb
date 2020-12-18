class AddPasswordProtectReportToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :password_protect_report, :boolean, default: false
  end
end
