class Estimations::Operations::Done < BaseOperation
  def call
    return validation_fail(args) unless mark_as_done

    slack_notify_if

    success(args)
  end

  private

  def mark_as_done
    record.done!
  end

  def slack_notify_if
    return if record.organization.slack_access_token.blank?

    SlackNotifierJob.perform_later(record.organization, :estimation_done, record)
  rescue StandardError => e
    Xlog.error(e)
  end
end
