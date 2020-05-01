class Specifications::Operations::SignOff < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    assign_attributes
    update_state

    success(args)
  end

  private

  def form_class
    Specifications::Forms::SignOff
  end

  def assign_attributes
    record.assign_attributes(record_params.merge!(signed_off_at: Time.current))
  end

  def update_state
    record.qa!
  end
end
