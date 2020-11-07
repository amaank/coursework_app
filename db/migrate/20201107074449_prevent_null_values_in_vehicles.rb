class PreventNullValuesInVehicles < ActiveRecord::Migration[5.2]
  def change
    change_column :vehicles, :registration_number, :string, null: false
    change_column :vehicles, :make, :string, null: false
    change_column :vehicles, :model, :string, null: false
  end
end
