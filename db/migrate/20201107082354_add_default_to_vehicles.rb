class AddDefaultToVehicles < ActiveRecord::Migration[5.2]
  def change
    change_column :vehicles, :colour, :string, default: "unspecified"
  end
end
