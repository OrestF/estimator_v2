class Estimation < ApplicationRecord
  include Filterable

  belongs_to :project
  belongs_to :user
  alias estimator user

  has_many :estimation_tasks

  enum state: %i[pending in_progress done]

  scope :by_project, ->(project) { where(project: project) }
end
