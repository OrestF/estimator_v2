class EstimationTask < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [])

  belongs_to :estimation
  belongs_to :feature

  validates :title, presence: true, uniqueness: { scope: :feature_id }
  validates :optimistic, :pessimistic, presence: true, numericality: { greater_than_or_equal_to: 1 }

  scope :by_feature, ->(feature) { where(feature: feature) }

  before_validation do
    self.organization_id = estimation.organization_id
  end

  RISK_COEFFICIENT = 1.3
end
