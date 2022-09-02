class CreateTableRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :sprint, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
