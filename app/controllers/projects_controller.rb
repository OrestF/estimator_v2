class ProjectsController < ApplicationController
  def index
    @projects = current_organization.projects
  end

  def new
    @project = record_class.new
  end

  def create
    Project.create(record_params)

    redirect_to projects_path
  end

  def show; end

  def edit; end

  def update; end

  private

  def record_class
    Project
  end

  def record_params
    params.require(:project).permit(:title, :description).merge!(user_id: current_user.id,
                                                                 organization_id: current_organization.id)
  end
end
