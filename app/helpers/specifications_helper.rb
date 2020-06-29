module SpecificationsHelper
  def deadline_chip_color(deadline)
    return 'default' if deadline.blank?
    return 'danger' if Time.current > (deadline - 1.hours)
    return 'warning' if Time.current > (deadline - 8.hours)

    'default'
  end

  def specification_templates_options
    SpecificationTemplate.where(organization_id: current_organization.id).pluck(:title, :id)
  end
end
