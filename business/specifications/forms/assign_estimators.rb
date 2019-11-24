# frozen_string_literal: true

class Specifications::Forms::AssignEstimators < BaseForm
  PERMITTED_ATTRIBUTES = %i[estimator_ids].freeze
  REQUIRED_ATTRIBUTES = PERMITTED_ATTRIBUTES
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)
end
