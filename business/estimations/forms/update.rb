# frozen_string_literal: true

class Estimations::Forms::Update < BaseForm
  PERMITTED_ATTRIBUTES = %i[title].freeze
  REQUIRED_ATTRIBUTES = PERMITTED_ATTRIBUTES
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)
end
