class Task < ApplicationRecord
  validates :name, presence: true
  # validates :status_votation, presence: true
  # validates :bio, length: { maximum: 1000 }

  belongs_to :sprint
  belongs_to :owner, class_name: 'User'
  has_many :votes, class_name: 'UserVote', dependent: :destroy

  enum status_votation: { nao_iniciado: 0, started: 1, finished: 2 }

  def trend_voted
    votes_by_count = votes.group(:score).count
    max_value(votes_by_count)
  end

  def ja_votou_usuarios
    sprint.room.users.map do |user|
      { user_id: user.id, ja_votou: user_ja_votou?(user) }
    end
  end

  def user_ja_votou?(user)
    user.room.users.include?(user)
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
