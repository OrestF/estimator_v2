class Organization < ApplicationRecord
  has_one_attached :logo

  has_many :users
  has_many :projects
  has_many :specifications, through: :users
  has_many :estimations, through: :specifications

  validates :name, presence: true, uniqueness: true
end
