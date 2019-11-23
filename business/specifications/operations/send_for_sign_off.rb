class Specifications::Operations::SendForSignOff < BaseOperation
  attr_reader :client
  def call
    build_form
    return validation_fail unless form_valid?
    return response(:fail, args) unless find_or_create_client

    assign_client_to_project
    send_email
    mark_as_client_sign_off

    success(args)
  end

  private

  def find_or_create_client
    @client = record.organization.users.find_or_initialize_by(email: record_params[:client_email],
                                                              role: :client,
                                                              organization_id: record.organization.id)

    return true if @client.persisted?

    @client.assign_attributes(password: SecureRandom.urlsafe_base64,
                              skip_invitation: true,
                              confirmed_at: Time.current)

    @client.save
  end

  def assign_client_to_project
    record.project.update(client_id: client.id)
  end

  def send_email
    # TODO: deliver_later
    SpecificationMailer.with(specification: record, client: client).send_for_sign_off.deliver_now
  end

  def mark_as_client_sign_off
    record.client_sign_off!
  end

  def form_class
    Specifications::Forms::SendForSignOff
  end
end
