class SlackNotifier
  BASE_URL = 'https://slack.com/oauth/authorize'.freeze

  attr_reader :client

  def initialize
    @client = Slack::Web::Client.new
  end
end
