class ApplicationDecorator < Draper::Decorator
  include ApplicationHelper

  def dc_state_badge
    return h.content_tag(:span, 'Deleted', class: 'badge badge-danger') unless deleted_at.nil?

    h.content_tag(:span, humanized_state(state), class: "badge badge-#{h.state_label(state)}")
  end
end
