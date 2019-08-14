# frozen_string_literal: true

class Projects::Forms::Base < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description].freeze
  REQUIRED_ATTRIBUTES = %i[title description].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
