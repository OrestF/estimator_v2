class Project < ApplicationRecord
  include SoftDeletable.new(dependant_relations: [:specifications])

  belongs_to :organization
  belongs_to :user
  belongs_to :client, foreign_key: :client_id, class_name: 'User', optional: true

  has_many :specifications

  has_rich_text :description

  validates :organization, :user, :title, :description, presence: true
  validates :title, uniqueness: { scope: %i[organization_id deleted_at], case_sensitive: false }

  enum state: {
    in_progress: 0,
    won: 1,
    failed: 2
  }
end
