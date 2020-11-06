class AddIndexToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_index :vehicles, :registration_number, unique: true
  end
end
