class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :registration_number
      t.string :make
      t.string :model
      t.string :colour

      t.timestamps
    end
  end
end
