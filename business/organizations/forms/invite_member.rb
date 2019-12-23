class Organizations::Forms::InviteMember < BaseForm
  PERMITTED_ATTRIBUTES = %i[email role].freeze
  REQUIRED_ATTRIBUTES = %i[email role].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates :email, format: Devise.email_regexp

  validate :validate_user_existence

  private

  def validate_user_existence
    return unless User.exists?(email: params[:email])

    errors.add(:email, 'already been taken')
  end
end
