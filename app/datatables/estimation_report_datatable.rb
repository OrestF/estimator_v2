class EstimationReportDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'EstimationReport.id' },
      title: { source: 'EstimationReport.title' },
      deadline: { source: 'EstimationReport.deadline' },
      user: { source: 'User.email' },
      project: { source: 'Project.title' }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        deadline: record.deadline,
        user: record.user.email,
        project: record.project.title,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      EstimationReport.all.joins(:user, :project).filter_collection(params.permit(:by_project))
    )
  end

  def actions(record)
    actions = safe_join([view_link(record, :estimation_report_path), edit_link(record, :edit_estimation_report_path)])

    actions.presence || 'Not allowed'
  end
end
