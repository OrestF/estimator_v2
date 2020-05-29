# frozen_string_literal: true

class EstimationTasks::Forms::Update < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description optimistic pessimistic experience_level].freeze
  REQUIRED_ATTRIBUTES = %i[title optimistic pessimistic].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
