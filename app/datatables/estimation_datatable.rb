class EstimationDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Estimation.id' },
      title: { source: 'Estimation.title' },
      domain: { source: 'User.domain' },
      estimator: { source: 'User.email' },
      state: { source: 'Estimation.state' },
      created_at: { source: 'Estimation.created_at' },
      project: { source: 'Project.title' }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.decorate.dc_title,
        domain: record.estimator.decorate.dc_domain,
        estimator: record.estimator.decorate.dc_full_name,
        state: record.decorate.dc_state_badge,
        project: record.project.title,
        created_at: record.created_at,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      Estimation.all.with_deleted.joins(:user, specification: :project).filter_collection(params.permit(:by_project))
    )
  end

  def actions(record)
    actions = safe_join([view_link(record, :estimation_path), edit_link(record, :edit_estimation_path), evaluate_link(record)])

    actions.presence || 'Not allowed'
  end

  def evaluate_link(record)
    return unless policy(record).evaluate?

    link_to(routes.evaluate_estimation_path(record), class: 'btn mr-1', title: 'Evaluate') do
      content_tag(:i, 'timelapse', class: 'material-icons')
    end
  end
end
