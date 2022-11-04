class Room < ApplicationRecord
  belongs_to :sprint

  has_many :users, dependent: :nullify

  def todos_votaram?
    return false if task_em_votacao.blank?

    task_em_votacao.votes.count >= users.count
  end

  def task_em_votacao
    sprint.tasks.find_by(status_votation: :started)
  end
end
