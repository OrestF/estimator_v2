class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  include Pundit
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::UrlHelper

  def current_user
    options[:current_user]
  end

  def current_organization
    options[:current_organization]
  end

  def policy_class
    options[:policy_class]
  end

  def scope
    options[:scope]
  end

  def routes
    Rails.application.routes.url_helpers
  end

  def view_link(record, path)
    return unless policy(record).show?

    link_to('View', routes.public_send(path, record), class: 'btn')
  end

  def edit_link(record, path, button_name = nil)
    return unless policy(record).edit? || policy(record).show?

    link_to(button_name || 'Edit', routes.public_send(path, record), class: 'btn')
  end

  def policy(record, configs = {})
    policy_class.new(current_user, record, configs.merge!(current_organization: current_organization))
  end
end
