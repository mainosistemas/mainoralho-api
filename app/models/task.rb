class Task < ApplicationRecord
  validates :name, presence: true
  validates :status_votation, presence: true

  belongs_to :sprint
  belongs_to :owner, class_name: 'User'
  has_many :votes, class_name: 'UserVote', dependent: :restrict_with_error

  enum status_votation: { not_started: 0, started: 1, finished: 2 }, _default: :not_started

  def trend_voted
    votes_by_count = votes.group(:score).count
    max_value(votes_by_count)
  end

  private

  def max_value(votes_by_count)
    max = votes_by_count.first

    votes_by_count.each do |vote|
      max = vote if vote[1] > max[1]
    end

    max[0]
  end
end
