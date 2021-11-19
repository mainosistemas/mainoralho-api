class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :rooms, dependent: :restrict_with_error
end
