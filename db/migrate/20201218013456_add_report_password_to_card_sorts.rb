class AddReportPasswordToCardSorts < ActiveRecord::Migration[6.0]
  def change
    add_column :card_sorts, :report_password, :string
  end
end
