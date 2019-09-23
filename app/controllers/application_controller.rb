class ApplicationController < ActionController::Base
  include ApplicationHelper
  include UiNotifications

  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  protected

  # TODO: add messages
  def user_not_authorized
    flash[:error] = 'Not authorized'
    redirect_to(root_path)
  end
end
