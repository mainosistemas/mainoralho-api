class AddColumnsInTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :status_votation, :integer
    add_column :tasks, :start_votation_time, :datetime
    add_column :tasks, :finish_votation_time, :datetime
    add_column :tasks, :limit_votation_time, :datetime
  end
end
