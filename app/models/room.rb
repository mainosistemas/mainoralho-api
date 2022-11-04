class Room < ApplicationRecord
  belongs_to :sprint

  has_many :user_rooms, dependent: :destroy
  has_one :user, through: :user_rooms

  def todos_votaram?
    return false if task_em_votacao.blank?

    task_em_votacao.votes.count >= user_rooms.where(tipo: :player).count
  end

  def task_em_votacao
    sprint.tasks.find_by(status_votation: :started)
  end
end
