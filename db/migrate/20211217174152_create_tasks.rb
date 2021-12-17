class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.references :sprint, null: false, foreign_key: true
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
