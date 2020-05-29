class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :persisted, -> { where.not(id: nil) }
end
