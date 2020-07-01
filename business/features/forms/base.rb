# frozen_string_literal: true

class Features::Forms::Base < BaseForm
  PERMITTED_ATTRIBUTES = %i[id title description acceptance_criteria specification_id user_id organization_id].freeze
  REQUIRED_ATTRIBUTES = %i[title specification_id user_id].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
