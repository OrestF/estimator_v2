class EstimationTask < ApplicationRecord
  belongs_to :estimation

  validates :title, presence: true, uniqueness: { scope: :estimation_id }
  validates :optimistic, :pessimistic, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
