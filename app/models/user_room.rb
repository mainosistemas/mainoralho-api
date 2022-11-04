class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum tipo: { moderador: 0, espectador: 1, player: 2 }
end
