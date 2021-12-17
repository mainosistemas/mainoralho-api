class ChangeReferencesSprint < ActiveRecord::Migration[7.0]
  def change
    remove_reference :sprints, :room, index: true
    add_reference :sprints, :project, foreign_key: true 
  end
end
