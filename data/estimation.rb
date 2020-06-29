class Estimation < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [:estimation_tasks])
  include Filterable

  belongs_to :user
  belongs_to :specification
  alias estimator user

  has_many :estimation_tasks
  has_one :project, through: :specification

  enum state: {
    pending: 0,
    in_progress: 1,
    done: 100
  }

  scope :by_project, ->(project) { all.merge(Specification.by_project(project)) }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :with_inactive, -> { unscope(where: :active) }

  before_validation do
    self.organization_id ||= specification.organization_id
  end

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
