# frozen_string_literal: true

class Estimations::Forms::Base < BaseForm
  PERMITTED_ATTRIBUTES = %i[title project_id user_id].freeze
  REQUIRED_ATTRIBUTES = %i[title project_id user_id].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
end
