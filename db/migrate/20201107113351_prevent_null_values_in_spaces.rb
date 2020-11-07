class PreventNullValuesInSpaces < ActiveRecord::Migration[5.2]
  def change
    change_column :spaces, :floor, :integer, null: false
    change_column :spaces, :row, :integer, null: false
    change_column :spaces, :column, :integer, null: false
  end
end
