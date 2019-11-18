class Features::Operations::Create < BaseOperation
  def call
    build_record
    build_form
    return validation_fail unless form_valid?

    return validation_fail unless save_record

    success(args.merge!(record: record))
  end

  private

  def build_record
    @record = Feature.new(record_params)
  end

  def form_class
    Features::Forms::Base
  end
end
