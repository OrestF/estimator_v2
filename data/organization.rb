class Organization < ApplicationRecord
  has_one_attached :logo

  has_many :users
  has_many :projects
  has_many :estimation_reports, through: :users
  has_many :estimations, through: :estimation_reports

  validates :name, presence: true, uniqueness: true
end
