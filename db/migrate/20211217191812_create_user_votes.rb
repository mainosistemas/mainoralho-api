class CreateUserVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :user_votes do |t|
      t.integer :score, null: false
      t.references :owner, foreign_key: { to_table: :users }
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
