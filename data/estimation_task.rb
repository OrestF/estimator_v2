class EstimationTask < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [])
  belongs_to :estimation
  belongs_to :feature

  validates :title, presence: true, uniqueness: { scope: :estimation_id }
  validates :optimistic, :pessimistic, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :by_feature, ->(feature) { where(feature: feature) }
end
