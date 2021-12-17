class ChangeReferencesProject < ActiveRecord::Migration[7.0]
  def change
    remove_reference :rooms, :project, index: true
    add_reference :rooms, :sprint, foreign_key: true 
  end
end
