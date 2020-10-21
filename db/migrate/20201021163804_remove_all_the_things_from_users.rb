class RemoveAllTheThingsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :communication_settings
    remove_column :users, :processor_id
    remove_column :users, :trial_ends_at
    remove_column :users, :card_type    
    remove_column :users, :card_last4   
    remove_column :users, :card_exp_month
    remove_column :users, :card_exp_year
    remove_column :users, :trialend
  end
end
