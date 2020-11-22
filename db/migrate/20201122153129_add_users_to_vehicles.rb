class AddUsersToVehicles < ActiveRecord::Migration[5.2]
  def up
    add_reference :vehicles, :user, index: true
    Vehicle.reset_column_information
    user = User.first

    Vehicle.all.each do |vehicle|
      vehicle.user_id = user.id
      vehicle.save!
    end

    change_column_null :vehicles, :user_id, false
    add_foreign_key :vehicles, :users
  end

  def down
    remove_foreign_key :vehicles, :users
    remove_reference :vehicles, :user, index: true
  end
end
