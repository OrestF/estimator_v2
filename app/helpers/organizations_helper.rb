module OrganizationsHelper
  def organization_path
    '/organization'
  end

  def organization_edit_path
    '/organization/edit'
  end

  def org_logo(options = {})
    return image_tag(current_organization.logo, class: 'img-fluid', **options) if current_organization.logo.attached?

    ''
  end
end
