class ProjectDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Project.id' },
      title: { source: 'Project.title' },
      state: { source: 'Project.state' },
      user: { source: 'User.email' },
      client: { source: 'User.email' },
      created_at: { source: 'Project.created_at' },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.decorate.title,
        state: record.decorate.dc_state_badge,
        user: record.user.decorate.dc_full_name,
        client: record.client&.decorate&.dc_full_name,
        created_at: record.created_at,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      current_organization.projects.includes(:user, :client)
    )
  end

  def actions(record)
    actions = safe_join([view_link(record, :project_path), edit_link(record, :edit_project_path)])

    actions.presence || 'Not allowed'
  end
end
