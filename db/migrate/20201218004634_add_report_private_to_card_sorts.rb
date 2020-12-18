class AddReportPrivateToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :report_private, :boolean, default: false
  end
end
