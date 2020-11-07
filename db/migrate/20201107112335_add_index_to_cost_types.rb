class AddIndexToCostTypes < ActiveRecord::Migration[5.2]
  def change
    add_index :cost_types, :name, unique: true
  end
end
