class Estimations::Operations::Create < BaseOperation
  def call
    build_record
    build_form
    return validation_fail unless form_valid?

    return validation_fail unless save_record

    success(args.merge!(record: record))
  end

  private

  def build_record
    @record = Estimation.new(record_params)
  end

  def form_class
    Estimations::Forms::Base
  end
end
