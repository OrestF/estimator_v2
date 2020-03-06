module ApplicationHelper
  def current_organization
    current_user&.organization
  end

  def nav_logo
    org_logo(size: '32x32').presence || image_pack_tag('estimator.png', size: '32x32')
  end

  def corner_button(url, **args)
    content_tag(:button, class: "btn btn-float btn-primary corner-button #{args[:css]}") do
      icon_link(url, **args)
    end
  end

  def icon_link(url, **args)
    link_to(url, **args[:link_params].to_h) do
      content_tag(:i, args[:icon] || 'link', class: 'material-icons', title: args[:title].presence || args[:icon].to_s.humanize)
    end
  end

  def corner_dropdown(**args)
    ApplicationController.new.render_to_string(partial: 'ui/corner_dropdown', assigns: args)
  end

  def state_label(state)
    case state
    when 'in_progress', 'qa'
      'info'
    when 'won', 'done', 'finished'
      'success'
    when 'estimation'
      'secondary'
    when 'failed'
      'danger'
    when 'client_sign_off'
      'warning'
    else
      'dark'
    end
  end

  def breadcrumbs(size = 3)
    session[:breadcrumbs] ||= []

    if request.format.html?
      cname = controller.controller_name
      cname = cname.singularize unless (aname = controller.action_name) == 'index'
      cname.prepend("#{aname} ") if aname == 'edit'
      session[:breadcrumbs] = (session[:breadcrumbs].to_a << { cname => request.fullpath })
    end

    session[:breadcrumbs].shift if session[:breadcrumbs].size > size

    session[:breadcrumbs]
  end

  def roles_for_select
    User.roles.keys - ['admin']
  end

  def policy_plus(record, action_name, configs = {})
    policy_klass = configs[:policy_class] || "#{record.class}Policy".constantize
    policy_klass.new(current_user, record, configs.merge!(current_organization: current_organization)).send("#{action_name}?")
  end

  def attachment_url(attachment, name: nil)
    link_to(name || attachment.filename, attachment, target: '_blank', rel: 'noopener')
  end
end
