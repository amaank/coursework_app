class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :space, foreign_key: true
      t.references :vehicle, foreign_key: true
      t.references :cost_type, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
