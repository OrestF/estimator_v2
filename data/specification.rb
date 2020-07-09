class Specification < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [:estimations, :features])
  include Filterable

  default_scope { not_deleted.where.not(project_id: nil) }

  attr_reader :template_id

  belongs_to :user
  belongs_to :project, optional: true # optional: true for SpecificationTemplate
  belongs_to :signed_off_by, class_name: 'User', optional: true

  has_one :organization, through: :user

  has_many :estimations, -> { merge(Estimation.active) }
  has_many :estimation_tasks, through: :estimations
  has_many :estimators, through: :estimations, source: :user

  has_many :features

  scope :by_project, ->(project) { where(project: project) }

  has_one_attached :summary_pdf

  validates :title, uniqueness: { scope: :project_id }

  before_validation do
    self.organization_id ||= project&.organization_id
  end

  enum state: {
    business_analysis: 0,
    sign_off: 1,
    qa: 2,
    estimation: 3,
    finished: 100
  }

  def total_optimistic
    estimations.active.sum(&:total_optimistic)
  end

  def total_pessimistic
    estimations.active.sum(&:total_pessimistic)
  end

  def may_finish?
    estimation?
  end

  def signed_off?
    [signed_off_by, signed_off_at].all?
  end

  def all_estimations_done?
    return false if estimations.none?

    estimations.all?(&:done?)
  end
end
