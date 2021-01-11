class EstimationTasks::Operations::Create < BaseOperation
  def call
    prepare_params
    build_record
    build_form
    return validation_fail unless form_valid?

    return validation_fail unless save_record

    mark_as_in_progress

    success(args.merge!(record: record))
  end

  private

  def prepare_params
    @record_params = EstimationTasks::Actions::PrepareParams.call(record_params: record_params).data[:record_params]
  end

  def build_record
    @record = EstimationTask.new(record_params)
  end

  def mark_as_in_progress
    record.estimation.in_progress! unless record.estimation.in_progress?
  end

  def form_class
    EstimationTasks::Forms::Create
  end
end
