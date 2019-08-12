class Projects::Operations::Create < BaseOperation
  def call
    build_record
    build_form
    return validation_fail unless form_valid?

    save_record
    return validation_fail unless record.persisted?

    success(args)
  end

  private

  def build_record
    @record = Project.new(record_params)
  end

  def form_class
    Projects::Forms::Base
  end
end
