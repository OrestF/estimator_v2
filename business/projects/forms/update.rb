# frozen_string_literal: true

class Projects::Forms::Update < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description domain state].freeze
  REQUIRED_ATTRIBUTES = %i[].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)
end
