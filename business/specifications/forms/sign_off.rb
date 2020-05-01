# frozen_string_literal: true

class Specifications::Forms::SignOff < BaseForm
  PERMITTED_ATTRIBUTES = %i[signed_off_by].freeze
  REQUIRED_ATTRIBUTES = %i[signed_off_by].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
