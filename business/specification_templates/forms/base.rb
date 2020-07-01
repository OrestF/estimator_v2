# frozen_string_literal: true

class SpecificationTemplates::Forms::Base < BaseForm
  PERMITTED_ATTRIBUTES = %i[title user_id organization_id].freeze
  REQUIRED_ATTRIBUTES = PERMITTED_ATTRIBUTES
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)
end
