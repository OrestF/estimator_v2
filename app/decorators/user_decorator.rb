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
    [first_name, last_name].join(' ')
  end

  def dc_domain
    h.capture do
      h.image_pack_tag("icons/#{domain}.svg", size: 32, alt: domain) +
      h.content_tag(:span, domain)
    end
  end
end
