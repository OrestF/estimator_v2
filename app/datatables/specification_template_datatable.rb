class SpecificationTemplateDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'SpecificationTemplate.id' },
      title: { source: 'SpecificationTemplate.title' },
      user: { source: 'User.email' },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        user: record.user.email,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(SpecificationTemplate.all)
  end

  def actions(record)
    actions = safe_join([view_link(record, :specification_template_path), edit_link(record, :edit_specification_template_path)])

    actions.presence || 'Not allowed'
  end
end
