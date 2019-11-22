# frozen_string_literal: true

class EstimationTasks::Forms::Update < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description optimistic pessimistic].freeze
  REQUIRED_ATTRIBUTES = PERMITTED_ATTRIBUTES - %i[id description]
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
