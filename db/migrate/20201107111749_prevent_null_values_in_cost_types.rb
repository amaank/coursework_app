class PreventNullValuesInCostTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :cost_types, :name, :string, null: false
    change_column :cost_types, :price, :decimal, precision: 5, scale: 2, null: false
    change_column :cost_types, :description, :text, null: false
  end
end
