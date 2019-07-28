module ApplicationHelper
  def current_organization
    current_user&.organization
  end

  def nav_logo
    org_logo(size: '32x32').presence || image_tag('estimator', size: '32x32')
  end
end
