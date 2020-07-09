class SlackNotifierJob < ApplicationJob
  queue_as :default

  def perform(organization, action_name, *args)
    SlackNotifier.new(organization.slack_access_token).send(action_name, *args)
  end
end
