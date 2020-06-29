class SpecificationTemplatesController < ResourcesController
  def create
    if (res = SpecificationTemplates::Operations::Create.call(specification: specification, user: current_user)).success?
      success_nf(MessageHelper.action('Specification template', 'created'))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_class
    Specification
  end

  def record
    @record ||= SpecificationTemplate.find(params[:id])
  end

  def specification
    @specification ||= Specification.find(params[:id])
  end
end
