class Project < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_many :estimation_reports

  # has_many :project_users
  # has_many :estimators, through: :project_users, source: :user
  #
  # has_many :estimations

  has_rich_text :description

  validates :organization, :user, :title, :description, presence: true
  validates :title, uniqueness: { scope: :organization_id, case_sensitive: false }
end
