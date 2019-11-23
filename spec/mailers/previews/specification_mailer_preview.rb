# Preview all emails at http://localhost:3000/rails/mailers/specification_mailer
class SpecificationMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/specification_mailer/send_for_sign_off
  def send_for_sign_off
    @specification = Specification.last
    @client = @specification.project.client
    @sign_off_request_url = routes.sign_off_request_specification_url(@specification,
                                                                      client_auth: Auth.basic_auth_string(@client))
  end

  private

  def routes
    Rails.application.routes.url_helpers
  end
end
