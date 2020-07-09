class SlackNotifier
  attr_reader :client, :channel

  def initialize(access_token)
    @client = Slack::Web::Client.new(token: access_token)
    @channel = '#estimation'
  end

  def m_send(message:, emails:, url: nil)
    text = "#{message}. Estimators: #{members_as_tags(emails)}"
    text += "<#{url}>" if url.present?

    client.chat_postMessage(channel: channel, text: text)
  end

  def assign_estimators(specification, emails)
    text = "New estimation for: #{specification.title}"
    text += "\n Estimators: #{members_as_tags(emails)}"
    text += "\n Project: #{url.project_url(specification.project)}"

    client.chat_postMessage(channel: channel, text: text)
  end

  def estimation_done(estimation)
    spec = estimation.specification

    text = "Hey, #{members_as_tags(spec.user)}. Estimation #{estimation.title} done! #{url.estimation_url(estimation)}"
    text += "\n Estimator: #{members_as_tags(estimation.estimator.email)}"
    text += "\n Estimations done: #{spec.estimations.done.count}/#{spec.estimations.count}"
    text += "\n All estimations for specification: #{spec.title} done!" if spec.all_estimations_done?
    text += "\n Specification #{url.specification_url(spec)}"

    client.chat_postMessage(channel: channel, text: text)
  end

  private

  def members(emails)
    client.users_list.members.select { |m| m.profile.email.present? && Array.wrap(emails).include?(m.profile.email) }
  end

  def members_as_tags(emails)
    members(emails).map { |m| "<@#{m.name}>" }.join(', ')
  end

  def url
    Rails.application.routes.url_helpers
  end
end
