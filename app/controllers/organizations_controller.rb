class OrganizationsController < ApplicationController
  def show; end

  def edit; end

  def update
    update_organization
    flash[:success] = 'Updated'
    redirect_to organization_path
  end

  private

  def record_params
    params.require(:organization).permit(:name, :logo)
  end

  def record_class
    Organization
  end

  def record
    current_organization
  end

  def update_organization
    current_organization.update(record_params)
    return if params.dig(:organization, :logo).blank?

    current_organization.logo.purge
    current_organization.logo.attach(params[:organization][:logo])
  end
end
