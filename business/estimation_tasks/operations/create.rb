class EstimationTasks::Operations::Create < BaseOperation
  def call
    build_record
    build_form
    return validation_fail unless form_valid?

    return validation_fail unless save_record

    success(args.merge!(record: record))
  end

  private

  def build_record
    @record = EstimationTask.new(record_params)
  end

  def form_class
    EstimationTasks::Forms::Base
  end
end
