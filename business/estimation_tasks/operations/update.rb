class EstimationTasks::Operations::Update < BaseOperation
  def call
    prepare_params
    build_form
    return validation_fail unless form_valid?

    assign_attributes
    return validation_fail unless save_record

    success(args.merge!(record: record))
  end

  private

  def form_class
    EstimationTasks::Forms::Update
  end

  def prepare_params
    @record_params = EstimationTasks::Actions::PrepareParams.call(record_params: record_params).data[:record_params]
  end
end
