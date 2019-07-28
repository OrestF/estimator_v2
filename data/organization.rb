class Organization < ApplicationRecord
  has_one_attached :logo

  has_many :users
  has_many :projects

  validates :name, presence: true, uniqueness: true
end
