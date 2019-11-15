module ApplicationHelper
  def current_organization
    current_user&.organization
  end

  def nav_logo
    org_logo(size: '32x32').presence || image_tag('estimator', size: '32x32')
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
    { 'in_progress' => 'light', 'won' => 'success', 'failed' => 'danger' }[state]
  end
end
