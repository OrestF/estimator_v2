class EstimationDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Estimation.id' },
      title: { source: 'Estimation.title' },
      state: { source: 'Estimation.state' },
      created_at: { source: 'Estimation.created_at' },
      project: { source: 'Project.title' }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        state: record.decorate.dc_state_badge,
        project: record.project.title,
        created_at: record.created_at,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      Estimation.all.joins(specification: :project).filter_collection(params.permit(:by_project))
    )
  end

  def actions(record)
    actions = safe_join([view_link(record, :estimation_path), edit_link(record, :edit_estimation_path)])

    actions.presence || 'Not allowed'
  end
end
