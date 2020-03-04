class SlackNotifier
  attr_reader :client

  def initialize(access_token)
    @client = Slack::Web::Client.new(token: access_token)
  end

  def m_send(message:, emails:, channel: '#estimation', url: nil)
    text = "#{message}. Estimators: #{members_as_tags(emails)}"
    text += "<#{url}>" if url.present?

    client.chat_postMessage(channel: channel, text: text)
  end

  private

  def members(emails)
    client.users_list.members.select { |m| m.profile.email.present? && emails.include?(m.profile.email) }
  end

  def members_as_tags(emails)
    members(emails).map { |m| "<@#{m.name}>" }.join(', ')
  end
end
