class AddTimeToVote < ActiveRecord::Migration[7.0]
  def change
    add_column :user_votes, :voted_moment_time, :datetime
  end
end
