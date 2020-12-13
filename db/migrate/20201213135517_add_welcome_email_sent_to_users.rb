class AddWelcomeEmailSentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :welcome_email_sent, :boolean, default: false
  end
end
