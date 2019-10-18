class EstimationDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Estimation.id' },
      title: { source: 'Estimation.title', cond: :like },
      state: { source: 'Estimation.state', cond: :like },
      project: { source: 'Project.title', cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        state: record.state,
        project: record.project.title
      }
    end
  end

  def get_raw_records
    policy_scope(
      Estimation.all.filter_collection(params.permit(:by_project))
    )
  end
end
