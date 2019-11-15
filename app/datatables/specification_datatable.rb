class SpecificationDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Specification.id' },
      title: { source: 'Specification.title' },
      deadline: { source: 'Specification.deadline' },
      user: { source: 'User.email' },
      state: { source: 'Specification.state' },
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
        state: record.state,
        project: record.project.title,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      Specification.all.joins(:user, :project).filter_collection(params.permit(:by_project))
    )
  end

  def actions(record)
    actions = safe_join([view_link(record, :specification_path), edit_link(record, :edit_specification_path)])

    actions.presence || 'Not allowed'
  end
end
