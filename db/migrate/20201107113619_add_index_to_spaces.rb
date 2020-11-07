class AddIndexToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_index :spaces, [:floor, :row, :column], unique: true
  end
end
