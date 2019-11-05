class Estimation < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :estimation_report
  alias estimator user

  has_many :estimation_tasks
  has_one :project, through: :estimation_report

  enum state: %i[pending in_progress done]

  scope :by_project, ->(project) { all.merge(EstimationReport.by_project(project)) }

  def total_optimistic
    estimation_tasks.sum(:optimistic).round(2)
  end

  def total_pessimistic
    estimation_tasks.sum(:pessimistic).round(2)
  end

  # TODO: move to decorators
  def totals
    {
      optimistic: total_optimistic,
      pessimistic: total_pessimistic
    }
  end
end
