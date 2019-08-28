class ProjectsController < ResourcesController
  def index
    @projects = current_organization.projects
  end

  def new
    @project = record_class.new
  end

  def create
    res = Projects::Operations::Create.call(record_params: record_params)

    if res.success?
      redirect_to projects_path
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  def show; end

  def edit; end

  def update;end

  private

  def record_class
    Project
  end

  def record_params
    params.require(:project).permit(:title, :description).to_h.merge!(user_id: current_user.id,
                                                                      organization_id: current_organization.id)
  end
end
