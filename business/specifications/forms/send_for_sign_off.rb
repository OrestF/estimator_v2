# frozen_string_literal: true

class Specifications::Forms::SendForSignOff < BaseForm
  PERMITTED_ATTRIBUTES = %i[client_email].freeze
  REQUIRED_ATTRIBUTES = %i[client_email].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates *REQUIRED_ATTRIBUTES, presence: true
  validates :client_email, format: { with: Devise.email_regexp }
end
