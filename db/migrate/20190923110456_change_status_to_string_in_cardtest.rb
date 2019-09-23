class ChangeStatusToStringInCardtest < ActiveRecord::Migration[5.2]
  def change
     change_column :cardtests, :status, :string
  end
end
