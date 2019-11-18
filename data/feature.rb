class Feature < ApplicationRecord
  belongs_to :specification
  belongs_to :user

  has_one :project, through: :specification

  validates :title, presence: true, uniqueness: { scope: :specification_id }
end
