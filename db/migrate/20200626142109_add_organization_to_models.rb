class AddOrganizationToModels < ActiveRecord::Migration[6.0]
  def change
    add_reference :specifications, :organization
    add_reference :estimations, :organization
    add_reference :estimation_tasks, :organization
    add_reference :features, :organization

    Specification.reset_column_information
    Estimation.reset_column_information
    EstimationTask.reset_column_information
    Feature.reset_column_information

    Specification.with_deleted.each(&:save)
    Estimation.with_deleted.each(&:save)
    EstimationTask.with_deleted.each(&:save)
    Feature.with_deleted.each(&:save)

    # Project.find_each do |project|
    #   project.specifications.find_each do |specification|
    #     specification.update(organization_id: project.organization_id)
    #
    #     specification.estimations.find_each do |estimation|
    #       estimation.update(organization_id: project.organization_id)
    #
    #       estimation.estimation_tasks.update_all(organization_id: project.organization_id)
    #     end
    #
    #     specification.features.update_all(organization_id: project.organization_id)
    #   end
    # end
  end
end
