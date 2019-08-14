class Project < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  has_rich_text :description

  validates :organization, :user, presence: true
  validates :title, uniqueness: { scope: :organization_id, case_sensitive: false }
end
