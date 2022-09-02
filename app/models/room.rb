class Room < ApplicationRecord
  belongs_to :sprint

  has_many :users, dependent: :nullify
end
