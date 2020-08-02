class Organizations::Forms::InviteMember < BaseForm
  PERMITTED_ATTRIBUTES = %i[email role domain experience_level].freeze
  REQUIRED_ATTRIBUTES = %i[email role domain].freeze
  attr_accessor(*PERMITTED_ATTRIBUTES, :record)

  validates :email, format: Devise.email_regexp
  validates :domain, inclusion: { in: User.domains.keys }

  validate :validate_user_existence

  private

  def validate_user_existence
    return unless User.exists?(email: params[:email])

    errors.add(:email, 'already been taken')
  end
end
