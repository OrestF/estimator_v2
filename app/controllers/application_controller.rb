class ApplicationController < ActionController::Base
  include ApplicationHelper

  include Pundit
  protect_from_forgery

  before_action :authenticate_user!
end
