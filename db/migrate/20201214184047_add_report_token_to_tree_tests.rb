class AddReportTokenToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :report_token, :string
  end
end
