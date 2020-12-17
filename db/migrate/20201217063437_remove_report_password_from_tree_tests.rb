class RemoveReportPasswordFromTreeTests < ActiveRecord::Migration[6.0]
  def change
    remove_column :tree_tests, :report_password, :string
  end
end
