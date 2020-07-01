class SpecificationTemplatesController < ResourcesController
  skip_before_action :verify_record, only: %i[create_from_specification]

  include Specifications::Features

  def index
    respond_to do |format|
      format.html
      format.json { render json: SpecificationTemplateDatatable.new(params, **dt_params) }
    end
  end

  def create
    if (res = SpecificationTemplates::Operations::Create.call(record_params: record_params)).success?
      success_nf(MessageHelper.action('Specification template', 'created'), url: specification_template_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def update
    if (res = SpecificationTemplates::Operations::Update.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.updated(record_class.name), url: specification_template_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def create_from_specification
    verify_class

    if (res = SpecificationTemplates::Operations::CreateFromSpecification.call(specification: specification, user: current_user)).success?
      success_nf(MessageHelper.action('Specification template', 'created'), url: specification_template_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show; end

  def edit; end

  private

  def record_class
    SpecificationTemplate
  end

  def record
    @record ||= SpecificationTemplate.find(params[:id])
  end

  def specification
    @specification ||= Specification.find(params[:id])
  end

  def render_feature_created(feature, _message: nil)
    render 'specification_templates/features/created', format: :js, status: :ok, locals: { feature: feature,
                                                                                  specification: record }
  end

  def record_params
    params[:specification_template].permit!.to_h.merge!(organization_id: current_organization.id, user_id: current_user.id)
  end
end
