class Projects::Operations::AssignEstimators < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    assign
    return response(:nested_operation_failed, args) unless create_estimations

    success(args)
  end

  private

  def assign
    record.estimators = record.organization.users.where(id: record_params[:estimator_ids])
  end

  def create_estimations
    record.estimators.map do |estimator|
      next if Estimation.exists?(estimation_params(estimator))

      Estimations::Operations::Create.call(record_params: estimation_params(estimator))
    end
  end

  def estimation_params(estimator)
    {
      title: "#{record.title} - #{estimator.email}",
      project_id: record.id,
      user_id: estimator.id
    }
  end

  def form_class
    Projects::Forms::AssignEstimators
  end
end
