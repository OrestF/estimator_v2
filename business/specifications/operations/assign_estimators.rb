class Specifications::Operations::AssignEstimators < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    create_estimations
    update_state
    slack_notify_if

    success(args)
  end

  private

  def update_state
    record.estimation!
  end

  def create_estimations
    estimators.map do |estimator|
      next if Estimation.exists?(estimation_params(estimator))

      Estimations::Operations::Create.call(record_params: estimation_params(estimator))
    end
  end

  def estimators
    @estimators ||= record.organization.users.where(id: record_params[:estimator_ids])
  end

  def estimation_params(estimator)
    {
      title: "#{record.title}: #{estimator.domain}",
      specification_id: record.id,
      user_id: estimator.id
    }
  end

  def form_class
    Specifications::Forms::AssignEstimators
  end

  def slack_notify_if
    return if record.organization.slack_access_token.blank?

    SlackNotifierJob.perform_later(record.organization, :assign_estimators, record, estimators.pluck(:email))
  rescue StandardError => e
    Xlog.error(e)
  end
end
