class Estimation < ApplicationRecord
  belongs_to :project
  belongs_to :user
  alias estimator user

  enum state: %i[pending in_progress done]
end
