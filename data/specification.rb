class Specification < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [:estimations, :features])
  include Filterable

  belongs_to :user
  belongs_to :project

  has_one :organization, through: :user

  has_many :estimations
  has_many :estimators, through: :estimations, source: :user

  has_many :features

  scope :by_project, ->(project) { where(project: project) }

  validates :title, uniqueness: { scope: :project_id }

  enum state: {
    business_analysis: 0,
    client_sign_off: 1,
    qa: 2,
    estimation: 3,
    finished: 100
  }

  def total_optimistic
    estimations.sum(&:total_optimistic)
  end

  def total_pessimistic
    estimations.sum(&:total_pessimistic)
  end
end
