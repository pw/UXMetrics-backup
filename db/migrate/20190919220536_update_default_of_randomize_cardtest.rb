class UpdateDefaultOfRandomizeCardtest < ActiveRecord::Migration[5.2]
  def up
    Cardtest.update_all({ :random => false})
  end
end
