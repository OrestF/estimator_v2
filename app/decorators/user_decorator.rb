class UserDecorator < ApplicationDecorator
  delegate_all

  def dc_title
    h.capture do
      dc_domain + ' - ' +
      h.content_tag(:span, dc_full_name.presence) +
      h.content_tag(:span, "[#{email}]")
    end
  end

  def dc_full_name
    [first_name, last_name].join(' ').presence || email
  end

  def dc_domain
    h.capture do
      dc_domain_icon +
      h.content_tag(:span, domain)
    end
  end

  def dc_domain_icon(css_class: '')
    h.image_pack_tag("icons/#{domain}.svg", size: 32, alt: domain, class: css_class)
  end
end
