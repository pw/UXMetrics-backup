class AddCreationStepToTreeTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tree_tests, :creation_step, :integer, default: 1
  end
end
