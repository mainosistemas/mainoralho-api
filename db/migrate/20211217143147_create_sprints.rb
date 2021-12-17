class CreateSprints < ActiveRecord::Migration[7.0]
  def change
    create_table :sprints do |t|
      t.string :name, null: false
      t.references :room
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
