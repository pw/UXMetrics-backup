class AddReportPasswordToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :report_password, :string
  end
end
