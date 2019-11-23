class Auth
  def self.basic_auth_string(user)
    Base64.urlsafe_encode64("#{user.email}:#{user.encrypted_password}")
  end

  def self.authenticate_basic(bauth)
    email, enc_pass = Base64.decode64(bauth).split(':')
    user = User.find_by(email: email)

    return user if user.present? && Devise.secure_compare(user.encrypted_password, enc_pass)

    false
  end
end
