class RemoveOldTables < ActiveRecord::Migration[5.2]
  def change
    drop_table :friendly_id_slugs
    drop_table :cards
    drop_table :results
    drop_table :cardtests
    drop_table :sjabloon_charges
    drop_table :sjabloon_coupons
    drop_table :sjabloon_plans
    drop_table :sjabloon_subscriptions
  end
end
