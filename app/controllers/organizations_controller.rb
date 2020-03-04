class OrganizationsController < ResourcesController
  def show
    @slack_url = connect_slack_url
  end

  def edit; end

  def update
    update_organization
    flash[:success] = 'Updated'
    redirect_to organization_path
  end

  def invite_member
    if (res = Organizations::Operations::InviteMember.call(record: current_organization, record_params: record_params)).success?
      success_nf(MessageHelper.action('Member', 'invited'), url: organization_path(current_organization))
    else
      error_nf(html_humanize_errors(res.errors))
    end
  end

  private

  def record_params
    params.require(:organization).permit!
  end

  def record_class
    Organization
  end

  def record
    current_organization
  end

  def update_organization
    current_organization.update(record_params)
    return if params.dig(:organization, :logo).blank?

    current_organization.logo.purge
    current_organization.logo.attach(params[:organization][:logo])
  end

  def connect_slack_url
    "https://slack.com/oauth/authorize?scope=#{slack_scopes.join(' ')}&client_id=#{RCreds.fetch(:my_slack, :client_id)}&redirect_uri=#{connect_slack_index_url}"
  end

  def slack_scopes
    %w[chat:write:user bot users:read users:read.email]
  end
end
