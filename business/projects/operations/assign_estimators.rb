class Projects::Operations::AssignEstimators < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    assign

    success(args)
  end

  private

  def assign
    record.estimators = record.organization.users.where(id: record_params[:estimator_ids])
  end

  def form_class
    Projects::Forms::AssignEstimators
  end
end
