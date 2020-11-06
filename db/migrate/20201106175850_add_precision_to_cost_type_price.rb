class AddPrecisionToCostTypePrice < ActiveRecord::Migration[5.2]
  def change
    change_column :cost_types, :price, :decimal, precision: 5, scale: 2
  end
end
