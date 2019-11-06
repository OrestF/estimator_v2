class EstimationReport < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :project

  has_one :organization, through: :user

  has_many :estimations
  has_many :estimators, through: :estimations, source: :user

  scope :by_project, ->(project) { where(project: project) }

  validates :title, uniqueness: { scope: :project_id }
end
