class AddPasswordProtectReportToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :password_protect_report, :boolean, default: false
  end
end
