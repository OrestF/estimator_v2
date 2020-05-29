# frozen_string_literal: true

class EstimationTasks::Forms::Create < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description optimistic pessimistic estimation_id feature_id experience_level].freeze
  REQUIRED_ATTRIBUTES = %i[title optimistic pessimistic estimation_id feature_id].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
