class Feature < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [:estimation_tasks])

  belongs_to :specification, optional: true
  belongs_to :specification_template, optional: true, foreign_key: :specification_id
  belongs_to :user

  has_one :project, through: :specification
  has_many :estimation_tasks

  validates :title, presence: true, uniqueness: { scope: %i[specification_id deleted_at] }

  before_validation do
    self.organization_id ||= specification.organization_id
  end
end
