class FixDefaultOfTreeOnTreeTests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tree_tests, :tree, "[{\"id\":0,\"text\":\"Home\",\"placeholder_text\":\"Home\",\"children\":[{\"id\":1,\"text\":\"Child\",\"placeholder_text\":\"Child\",\"children\":[{\"id\":2,\"text\":\"Child of Child\",\"placeholder_text\":\"Child of Child\",\"children\":[]}]}]}]"
  end
end
