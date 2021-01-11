class ProjectDecorator < ApplicationDecorator
  delegate_all

  def dc_domain
    return if domain.blank?

    h.content_tag(:span, domain, class: 'badge badge-primary')
  end
end
