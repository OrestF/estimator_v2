module OrganizationsHelper
  def organization_path
    '/organization'
  end

  def organization_edit_path
    '/organization/edit'
  end

  def org_logo(options = {})
    if current_organization.logo.attached?
      return image_tag(current_organization.logo, class: "img-fluid  #{options[:css_class]}", **options)
    end

    ''
  end
end
