class PreventNullValuesInBookings < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :space_id, :integer, null: false
    change_column :bookings, :vehicle_id, :integer, null: false
    change_column :bookings, :cost_type_id, :integer, null: false
    change_column :bookings, :date, :date, null: false
  end
end
