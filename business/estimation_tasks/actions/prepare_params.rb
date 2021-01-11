class EstimationTasks::Actions::PrepareParams < BaseAction
  attr_reader :record_params
  def call
    patch_pessimistic_if

    response(:success, record_params: record_params)
  end

  private

  def patch_pessimistic_if
    return if record_params[:pessimistic].present?

    record_params[:pessimistic] = record_params[:optimistic].to_i * EstimationTask::RISK_COEFFICIENT
    record_params
  end
end
