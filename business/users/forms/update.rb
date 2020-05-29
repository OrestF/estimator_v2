# frozen_string_literal: true

class Users::Forms::Update < BaseForm
  PERMITTED_ATTRIBUTES = %i[id email domain first_name last_name experience_level].freeze
  REQUIRED_ATTRIBUTES = %i[].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)
end
