class ApplicationMailer < ActionMailer::Base
  default from: 'mailer@estimator.com'
  layout 'mailer'

  protected

  def routes
    Rails.application.routes.url_helpers
  end
end
