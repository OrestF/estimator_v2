class EstimationDecorator < ApplicationDecorator
  delegate_all

  def dc_title
    h.capture do
      dc_domain + (title.presence || estimator.decorate.dc_full_name)
    end
  end

  def dc_domain
    estimator.decorate.dc_domain_icon(css_class: 'mr-2')
  end
end
