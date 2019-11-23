class SpecificationMailer < ApplicationMailer
  def send_for_sign_off
    @specification = params[:specification]
    @client = params[:client]
    @sign_off_request_url = routes.sign_off_request_specification_url(@specification,
                                                                      client_auth: Auth.basic_auth_string(@client))

    mail(to: @client.email, subject: "Sign off request for #{@specification.title}")
  end
end
