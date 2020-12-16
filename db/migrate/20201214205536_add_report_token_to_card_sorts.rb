class AddReportTokenToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :report_token, :string
  end
end
