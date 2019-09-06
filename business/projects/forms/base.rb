# frozen_string_literal: true

class Projects::Forms::Base < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description user_id organization_id].freeze
  REQUIRED_ATTRIBUTES = %i[title description user_id organization_id].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
