class AddTrialendToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :trialend, :string
  end
end
