class ApplicationDecorator < Draper::Decorator
  include ApplicationHelper

  def dc_state_badge
    h.content_tag(:span, humanized_state(state), class: "badge badge-#{h.state_label(state)}")
  end
end
