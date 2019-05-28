class OrganizationsController < ApplicationController
  def show; end

  def edit
    authorize current_organization
  end

  def update
    authorize current_organization

    current_organization.update(record_params)
    current_organization.logo.purge
    current_organization.logo.attach(params[:organization][:logo])
    flash[:success] = 'Updated'
    redirect_to root_path
  end

  private

  def record_params
    params.require(:organization).permit(:name, :logo)
  end

  def record_class
    Organization
  end
end
