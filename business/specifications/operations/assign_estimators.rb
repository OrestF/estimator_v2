class Specifications::Operations::AssignEstimators < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    create_estimations
    update_state
    slack_notify

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
      title: "#{record.title} - #{estimator.email}",
      specification_id: record.id,
      user_id: estimator.id
    }
  end

  def form_class
    Specifications::Forms::AssignEstimators
  end

  def slack_notify
    return if record.organization.slack_access_token.blank?

    SlackNotifier.new(organization.slack_access_token).m_send(message: "New estimation for: #{record.title}",
                                                              emails: estimators.pluck(:email),
                                                              url: Rails.application.routes.url_helpers.project_url(record.project))
  end
end
