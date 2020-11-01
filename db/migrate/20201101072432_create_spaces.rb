class CreateSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :spaces do |t|
      t.integer :floor
      t.integer :row
      t.integer :column

      t.timestamps
    end
  end
end
