class DropRoomsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :rooms
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
