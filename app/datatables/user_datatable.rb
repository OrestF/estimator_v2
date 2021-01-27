class UserDatatable < ApplicationDatatable
  def view_columns
    @view_columns ||= {
      id: { source: 'User.id' },
      email: { source: 'User.email' },
      first_name: { source: 'User.first_name' },
      last_name: { source: 'User.last_name' },
      role: { source: 'User.role' },
      domain: { source: 'User.domain' },
      experience_level: { source: 'User.experience_level' },
      invitation_state: { source: 'User.invitation_accepted_at' }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        email: record.email,
        first_name: record.first_name,
        last_name: record.last_name,
        role: record.role,
        domain: record.decorate.dc_domain,
        experience_level: record.experience_level,
        invitation_state: record.invitation_accepted_at,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    policy_scope(
      current_organization.users
    )
  end

  def actions(record)
    actions = safe_join([edit_link(record, :edit_user_path)])

    actions.presence || 'Not allowed'
  end
end
