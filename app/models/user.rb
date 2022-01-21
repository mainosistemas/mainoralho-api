class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :projects, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :sprints, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :rooms, foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :tasks, foreign_key: :owner_id, dependent: :restrict_with_error
end
