class ProjectsController < ResourcesController
  def index
    @records = current_organization.projects
  end

  def new
    @record = record_class.new
  end

  def create
    if (res = Projects::Operations::Create.call(record_params: record_params)).success?
      success_nf(MessageHelper.saved(record_class.name), url: project_path(res.data[:record]))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show
    @new_specification = record.specifications.new
  end

  def edit; end

  def update
    if (res = Projects::Operations::Update.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.updated(record_class.name), url: project_path(record))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def destroy
    if (res = Projects::Operations::Delete.call(record: record)).success?
      success_nf(MessageHelper.deleted(record_class.name), url: projects_path)
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def assign_estimators
    if (res = Projects::Operations::AssignEstimators.call(record: record, record_params: record_params)).success?
      success_nf(MessageHelper.action('Estimators assigned', ''))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_class
    Project
  end

  def record_params
    params.require(:project).permit!.to_h.merge!(user_id: current_user.id,
                                                 organization_id: current_organization.id)
  end
end
