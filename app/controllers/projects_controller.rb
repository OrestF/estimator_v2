class ProjectsController < ApplicationController
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
      # TODO: ADD FUCKING JS NOTIFICATIONS WWITH FUCKED WEBPACKER
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update; end

  private

  def record_class
    Project
  end

  def record_params
    params.require(:project).permit(:title, :description).to_h.merge!(user_id: current_user.id,
                                                                      organization_id: current_organization.id)
  end
end
