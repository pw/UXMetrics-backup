class AddDefaultToReportPasswordOnCardSorts < ActiveRecord::Migration[6.0]
  def change
    change_column_default :card_sorts, :report_password, ''
  end
end
