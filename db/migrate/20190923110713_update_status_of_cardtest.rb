class UpdateStatusOfCardtest < ActiveRecord::Migration[5.2]
  def change
    Cardtest.update_all({ :status => "draft"})
  end
end
