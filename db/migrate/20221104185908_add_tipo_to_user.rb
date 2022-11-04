class AddTipoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tipo, :integer
  end
end
