class Estimation < ApplicationRecord
  include Filterable

  belongs_to :project
  belongs_to :user
  alias estimator user

  enum state: %i[pending in_progress done]

  scope :by_project, ->(project) { where(project: project) }
end
