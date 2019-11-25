class ApplicationDecorator < Draper::Decorator
  def dc_state_badge
    h.content_tag(:span, state, class: "badge badge-#{h.state_label(state)}")
  end
end
