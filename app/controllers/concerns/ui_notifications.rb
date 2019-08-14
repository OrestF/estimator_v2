module UiNotifications
  extend ActiveSupport::Concern

  def error_nf(message)
    render 'ui/alertify', format: :js, status: :bad_request, locals: { status: 'error', message: message }
  end

  # TODO: move to proper place & render as html
  def humanize_errors(errors_hash)
    return '' if errors_hash.blank?

    errors_hash.map { |name, messages| "#{name.to_s.humanize}: #{messages.join('; ')}" }.join('. ')
  end

  def html_humanize_errors(errors_hash)
    return '' if errors_hash.blank?

    render_to_string(partial: 'ui/errors', locals: { error_messages: errors_hash })
  end
end
