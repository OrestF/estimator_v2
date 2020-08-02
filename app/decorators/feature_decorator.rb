class FeatureDecorator < ApplicationDecorator
  delegate_all

  def dc_description_criteria_html
    h.capture do
      h.content_tag(:div, description) +
        h.content_tag(:div, "\n") +
        h.content_tag(:div, acceptance_criteria)
    end
  end

  def dc_description_criteria
    h.capture do
      description +
        "\n" +
        acceptance_criteria
    end
  end
end
