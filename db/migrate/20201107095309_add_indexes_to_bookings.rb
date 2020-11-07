class AddIndexesToBookings < ActiveRecord::Migration[5.2]
  def change
    add_index :bookings, [:space_id, :date], unique: true
    add_index :bookings, [:vehicle_id, :date], unique: true
  end
end
