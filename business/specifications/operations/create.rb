class Specifications::Operations::Create < BaseOperation
  def call
    estimator_ids

    build_record
    build_form
    return validation_fail unless form_valid?

    copy_from_template if template.present?

    return validation_fail unless save_record

    success(args.merge!(record: record))
  end

  private

  def build_record
    @record = Specification.new(record_params.except(:estimator_ids, :template_id))
  end

  def estimator_ids
    @estimator_ids ||= record_params.delete(:estimator_ids)
  end

  def form_class
    Specifications::Forms::Base
  end

  def copy_from_template
    template.features.each do |feature|
      record.features.new(feature.slice(:title, :description, :acceptance_criteria).merge!(organization_id: organization.id,
                                                                                           user_id: record.user_id))
    end
  end

  def template
    @template ||= SpecificationTemplate.find_by(id: record_params[:template_id])
  end

  def organization
    @organization ||= User.find(record_params[:user_id]).organization
  end
end
