class Project < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :client, foreign_key: :client_id, class_name: 'User', optional: true

  has_many :specifications

  # has_many :project_users
  # has_many :estimators, through: :project_users, source: :user
  #
  # has_many :estimations

  has_many :chat_rooms, as: :chatable

  has_rich_text :description

  validates :organization, :user, :title, :description, presence: true
  validates :title, uniqueness: { scope: :organization_id, case_sensitive: false }

  enum state: {
    in_progress: 0,
    won: 1,
    failed: 2
  }
end
