class EstimationDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'Estimation.id' },
      title: { source: 'Estimation.title', cond: :like },
      state: { source: 'Estimation.state', cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        state: record.state
      }
    end
  end

  def get_raw_records
    policy_scope(Estimation.all)
  end
end
