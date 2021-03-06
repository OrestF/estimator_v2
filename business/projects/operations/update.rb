class Projects::Operations::Update < BaseOperation
  def call
    build_form
    return validation_fail unless form_valid?

    assign_attributes
    return validation_fail unless save_record

    success(args)
  end

  private

  def form_class
    Projects::Forms::Update
  end
end
