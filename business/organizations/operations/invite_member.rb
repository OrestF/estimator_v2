class Organizations::Operations::InviteMember < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    build_user
    save_user
    invite_user
    success(args)
  end

  private

  def build_user
    @user = User.new(email: record_params[:email], role: record_params[:role], organization: record)
  end

  def invite_user
    @user.invite!
  end

  def save_user
    @user.save(validate: false)
  end

  def form_class
    Organizations::Forms::InviteMember
  end
end
