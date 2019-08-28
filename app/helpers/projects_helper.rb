module ProjectsHelper
  def project_form_attr(project, attributes = {})
    base = {
      model: project,
      url: project_path,
      local: false,
      method: :post
    }

    base.merge!(url: project_path(project), method: :patch) if project.persisted?
    base.merge!(attributes.to_h)

    base
  end
end
