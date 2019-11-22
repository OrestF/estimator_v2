class Feature < ApplicationRecord
  belongs_to :specification
  belongs_to :user

  has_one :project, through: :specification
  has_many :estimation_tasks

  validates :title, presence: true, uniqueness: { scope: :specification_id }
end
