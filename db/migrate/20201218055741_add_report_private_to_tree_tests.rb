class AddReportPrivateToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :report_private, :boolean, default: false
  end
end
