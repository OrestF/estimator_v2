class ApplicationDatatable < AjaxDatatablesRails::ActiveRecord
  include Pundit
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Context

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

    link_to(routes.public_send(path, record), class: 'btn mr-1', title: 'Open') do
      content_tag(:span, 'open')
    end
  end

  def edit_link(record, path)
    return unless policy(record).edit? || policy(record).show?

    link_to(routes.public_send(path, record), class: 'btn mr-1', title: 'Edit') do
      content_tag(:i, 'edit', class: 'material-icons')
    end
  end

  def restore_link(record, path)
    return unless record.deleted? && policy(record).destroy?

    link_to(routes.public_send(path, record), class: 'btn mr-1', title: 'Restore', method: :put) do
      content_tag(:i, 'restore_from_trash', class: 'material-icons')
    end
  end

  def policy(record, configs = {})
    policy_class.new(current_user, record, configs.merge!(current_organization: current_organization))
  end
end
