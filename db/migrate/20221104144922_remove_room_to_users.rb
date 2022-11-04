class RemoveRoomToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :room
  end
end
