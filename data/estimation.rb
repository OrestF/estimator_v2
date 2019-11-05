class Estimation < ApplicationRecord
  include Filterable

  belongs_to :project
  belongs_to :user
  alias estimator user

  has_many :estimation_tasks

  enum state: %i[pending in_progress done]

  scope :by_project, ->(project) { where(project: project) }

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
