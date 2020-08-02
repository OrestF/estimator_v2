class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def connect
    rc = Slack::Web::Client.new.oauth_access(client_id: RCreds.fetch(:slack, :client_id),
                                             client_secret: RCreds.fetch(:slack, :client_secret),
                                             code: params[:code])

    current_organization.update(slack_access_token: rc.access_token)
    flash[:success] = 'Slack successfully connected'
    redirect_to(root_path)
  rescue StandardError => e
    flash[:error] = e.message

    redirect_to(organization_path)
  end

  private

  # rubocop:disable Layout/LineLength
  def connect_slack_url
    "https://slack.com/oauth/authorize?scope=#{slack_scopes.join(' ')}&client_id=#{RCreds.fetch(:my_slack, :client_id)}&redirect_uri=#{connect_slack_index_url}"
  end
  # rubocop:enable Layout/LineLength

  def slack_scopes
    %w[chat:write:user bot users:read users:read.email]
  end
end
